{ pkgs, ... }:

{
  services.jellyfin = {
    enable = true;
    openFirewall = true;

    cacheDir = "/srv/library/jellyfin-cache";
  };

  environment.systemPackages = with pkgs; [
    python3
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
  ];
}
