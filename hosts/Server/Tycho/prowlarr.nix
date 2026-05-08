{ ... }:
{
  services.prowlarr = {
    enable = true;
    openFirewall = false;
  };

  systemd.services.prowlarr.serviceConfig = {
    Environment = [
      "PROWLARR__BINDADDRESS=127.0.0.1"
      "PROWLARR__PORT=9696"
    ];
    UMask = "0002";
  };

  users.users.prowlarr.extraGroups = [
    "media"
    "users"
  ];
}
