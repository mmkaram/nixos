{ pkgs, ... }:

{
  services.jellyfin = {
    enable = true;
    openFirewall = true;

    extraOptions = [
      "--cachedir=/srv/library/jellyfin-cache"
    ];
  };

  systemd.tmpfiles.rules = [
    "d /srv/library/jellyfin-cache 0750 jellyfin jellyfin -"
    "d /srv/library/jellyfin-transcodes 0750 jellyfin jellyfin -"
  ];

  environment.systemPackages = with pkgs; [
    python3
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
  ];
}
