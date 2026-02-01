{ pkgs, ... }:
{
  users.users.qbt = {
    isSystemUser = true;
    group = "qbt";
    home = "/var/lib/qbt";
    createHome = true;
  };
  users.groups.qbt = { };

  environment.systemPackages = [ pkgs.qbittorrent-nox ];

  systemd.tmpfiles.rules = [
    "d /srv/downloads/torrents 0775 qbt users -"
    "d /var/lib/qbt 0750 qbt qbt -"
  ];

  systemd.services.qbittorrent-nox = {
    description = "qBittorrent-nox";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      User = "qbt";
      Group = "qbt";
      ExecStart = "${pkgs.qbittorrent-nox}/bin/qbittorrent-nox --webui-port=8080";
      Restart = "on-failure";
      TimeoutStopSec = 30;
    };
  };
}
