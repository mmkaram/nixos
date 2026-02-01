{ ... }:
{
  services.lidarr = {
    enable = true;
    openFirewall = false;
  };

  systemd.services.lidarr.serviceConfig = {
    Environment = [
      "LIDARR__BINDADDRESS=127.0.0.1"
      "LIDARR__PORT=8686"
    ];
    UMask = "0002";
  };
}
