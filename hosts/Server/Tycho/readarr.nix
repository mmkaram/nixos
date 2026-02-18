{ ... }:
{
  services.readarr = {
    enable = true;
    openFirewall = false;
  };

  systemd.services.readarr.serviceConfig = {
    Environment = [
      "READARR__BINDADDRESS=127.0.0.1"
      "READARR__PORT=8787"
    ];
    UMask = "0002";
  };
}
