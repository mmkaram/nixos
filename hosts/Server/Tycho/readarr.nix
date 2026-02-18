{ ... }:
{
  services.readarr = {
    enable = true;
    openFirewall = false;
  };

  systemd.services.readarr.serviceConfig = {
    Environment = [
      "RADARR__BINDADDRESS=127.0.0.1"
      "RADARR__PORT=8787"
    ];
    UMask = "0002";
  };
}
