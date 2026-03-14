{
  pkgs,
  config,
  lib,
  ...
}:
let
  # Network namespace configuration
  nsName = "qbt-vpn";
  vethHost = "veth-host";
  vethNs = "veth-vpn";
  hostIp = "10.200.200.1";
  nsIp = "10.200.200.2";
  subnet = "10.200.200.0/24";

  # Mullvad WireGuard server (US NYC)
  mullvadEndpoint = "146.70.174.2:51820";
  mullvadPubkey = "CIo1rbwvTjg3xJRsMxDK0bWelKPFMYk1R3JrnPk9iS0=";
in
{
  # qBittorrent user and group
  users.users.qbt = {
    isSystemUser = true;
    group = "qbt";
    home = "/var/lib/qbt";
    createHome = true;
  };
  users.groups.qbt = { };

  environment.systemPackages = with pkgs; [
    qbittorrent-nox
    wireguard-tools
  ];

  # Download directories
  systemd.tmpfiles.rules = [
    "d /srv/library/downloads 0775 qbt users -"
    "d /var/lib/qbt 0750 qbt qbt -"
  ];

  # Prevent NetworkManager from managing veth interfaces
  networking.networkmanager.unmanaged = [ "interface-name:veth-*" ];

  # Enable IP forwarding for namespace communication
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
  };

  # Service 1: Create network namespace and veth pair
  systemd.services.qbt-vpn-netns = {
    description = "Create qBittorrent VPN network namespace";
    before = [ "qbt-vpn-wireguard.service" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = pkgs.writeShellScript "qbt-vpn-netns-up" ''
        set -e
        ${pkgs.iproute2}/bin/ip netns add ${nsName} || true

        # Create veth pair
        ${pkgs.iproute2}/bin/ip link add ${vethHost} type veth peer name ${vethNs}

        # Move one end to namespace
        ${pkgs.iproute2}/bin/ip link set ${vethNs} netns ${nsName}

        # Configure host side
        ${pkgs.iproute2}/bin/ip addr add ${hostIp}/24 dev ${vethHost}
        ${pkgs.iproute2}/bin/ip link set ${vethHost} up

        # Configure namespace side
        ${pkgs.iproute2}/bin/ip netns exec ${nsName} ${pkgs.iproute2}/bin/ip addr add ${nsIp}/24 dev ${vethNs}
        ${pkgs.iproute2}/bin/ip netns exec ${nsName} ${pkgs.iproute2}/bin/ip link set ${vethNs} up
        ${pkgs.iproute2}/bin/ip netns exec ${nsName} ${pkgs.iproute2}/bin/ip link set lo up

        # Enable NAT for namespace to reach Mullvad endpoint via host
        # Dynamically detect the default interface
        DEFAULT_IF=$(${pkgs.iproute2}/bin/ip route | ${pkgs.gawk}/bin/awk '/default/ {print $5; exit}')
        ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s ${subnet} -o "$DEFAULT_IF" -j MASQUERADE || true
        ${pkgs.iptables}/bin/iptables -A FORWARD -i ${vethHost} -o "$DEFAULT_IF" -j ACCEPT || true
        ${pkgs.iptables}/bin/iptables -A FORWARD -i "$DEFAULT_IF" -o ${vethHost} -m state --state RELATED,ESTABLISHED -j ACCEPT || true
      '';
      ExecStop = pkgs.writeShellScript "qbt-vpn-netns-down" ''
        DEFAULT_IF=$(${pkgs.iproute2}/bin/ip route | ${pkgs.gawk}/bin/awk '/default/ {print $5; exit}')
        ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s ${subnet} -o "$DEFAULT_IF" -j MASQUERADE || true
        ${pkgs.iptables}/bin/iptables -D FORWARD -i ${vethHost} -o "$DEFAULT_IF" -j ACCEPT || true
        ${pkgs.iptables}/bin/iptables -D FORWARD -i "$DEFAULT_IF" -o ${vethHost} -m state --state RELATED,ESTABLISHED -j ACCEPT || true
        ${pkgs.iproute2}/bin/ip link del ${vethHost} || true
        ${pkgs.iproute2}/bin/ip netns del ${nsName} || true
      '';
    };
  };

  # Service 2: Configure WireGuard inside namespace
  systemd.services.qbt-vpn-wireguard = {
    description = "WireGuard VPN in qBittorrent namespace";
    after = [ "qbt-vpn-netns.service" ];
    requires = [ "qbt-vpn-netns.service" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = pkgs.writeShellScript "qbt-vpn-wg-up" ''
        set -e

        # Read secrets
        PRIVATE_KEY=$(cat ${config.age.secrets.mullvad-wg-private.path})
        ADDRESS=$(cat ${config.age.secrets.mullvad-wg-address.path})

        # Create WireGuard interface inside namespace
        ${pkgs.iproute2}/bin/ip link add wg0 type wireguard
        ${pkgs.iproute2}/bin/ip link set wg0 netns ${nsName}

        # Configure WireGuard
        ${pkgs.iproute2}/bin/ip netns exec ${nsName} ${pkgs.wireguard-tools}/bin/wg set wg0 \
          private-key <(echo "$PRIVATE_KEY") \
          peer ${mullvadPubkey} \
          endpoint ${mullvadEndpoint} \
          allowed-ips 0.0.0.0/0 \
          persistent-keepalive 25

        # Bring up interface and configure routing
        ${pkgs.iproute2}/bin/ip netns exec ${nsName} ${pkgs.iproute2}/bin/ip addr add "$ADDRESS" dev wg0
        ${pkgs.iproute2}/bin/ip netns exec ${nsName} ${pkgs.iproute2}/bin/ip link set wg0 up

        # Route to Mullvad endpoint via veth (for WireGuard handshake)
        ${pkgs.iproute2}/bin/ip netns exec ${nsName} ${pkgs.iproute2}/bin/ip route add ${lib.head (lib.splitString ":" mullvadEndpoint)}/32 via ${hostIp}

        # Default route through WireGuard (kill switch - all traffic goes via VPN)
        ${pkgs.iproute2}/bin/ip netns exec ${nsName} ${pkgs.iproute2}/bin/ip route add default dev wg0
      '';
      ExecStop = pkgs.writeShellScript "qbt-vpn-wg-down" ''
        ${pkgs.iproute2}/bin/ip netns exec ${nsName} ${pkgs.iproute2}/bin/ip link del wg0 || true
      '';
    };
  };

  # Service 3: qBittorrent running inside the namespace
  systemd.services.qbittorrent-nox = {
    description = "qBittorrent-nox (VPN isolated)";
    after = [
      "qbt-vpn-wireguard.service"
      "network-online.target"
    ];
    requires = [ "qbt-vpn-wireguard.service" ];
    bindsTo = [ "qbt-vpn-wireguard.service" ]; # Kill switch: stop if VPN fails
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      User = "qbt";
      Group = "qbt";
      NetworkNamespacePath = "/run/netns/${nsName}";
      ExecStart = "${pkgs.qbittorrent-nox}/bin/qbittorrent-nox --webui-port=8080";
      Restart = "on-failure";
      TimeoutStopSec = 30;

      # Hardening
      PrivateTmp = true;
      ProtectSystem = "strict";
      ProtectHome = true;
      ReadWritePaths = [
        "/var/lib/qbt"
        "/srv/library/downloads"
      ];
    };
  };

}
