{ config, pkgs, ... }:

{
  services.samba = {
    enable = true;
    openFirewall = true;
    
    settings = {
      global = {
        workgroup = "WORKGROUP";
        "server string" = "NixOS Samba Server";
        "netbios name" = "nixos";
        security = "user";
        "hosts allow" = "192.168.0. 192.168.1. 10.0.0. 127.0.0.1 localhost";
        "hosts deny" = "0.0.0.0/0";
        "guest account" = "nobody";
        "map to guest" = "bad user";
      };
      
      public = {
        path = "/srv/samba";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "yes";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "nobody";
        "force group" = "nogroup";
      };
    };
  };

  # Create necessary Samba directories
  systemd.tmpfiles.rules = [
    "d /srv/samba 0755 nobody nogroup -"
    "d /var/lib/samba 0755 root root -"
    "d /var/lib/samba/private 0700 root root -"
    "d /var/log/samba 0755 root root -"
    "d /var/cache/samba 0755 root root -"
  ];
}
