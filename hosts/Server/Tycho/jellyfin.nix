{ pkgs, ... }:
{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };
  environment.systemPackages = with pkgs; [
    python3
    # jf
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
  ];

}
