{ ... }:
{
  services.radarr = {
    enable = true;
    openFirewall = false;
  };

  systemd.services.radarr.serviceConfig = {
    Environment = [
      "RADARR__BINDADDRESS=127.0.0.1"
      "RADARR__PORT=7878"
    ];
    UMask = "0002";
  };
}
