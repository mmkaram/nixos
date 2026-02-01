{
  ...
}:
{
  services.prowlarr = {
    enable = true;
    openFirewall = false;
  };

  # Bind UI to localhost only (Prowlarr listens on 9696 by default)
  systemd.services.prowlarr.serviceConfig = {
    Environment = [
      "PROWLARR__BINDADDRESS=127.0.0.1"
      "PROWLARR__PORT=9696"
    ];
  };
}
