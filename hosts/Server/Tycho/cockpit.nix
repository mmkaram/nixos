{ ... }:
{
  services.cockpit = {
    enable = true;
    port = 9091;
    openFirewall = true;
    showBanner = true;
    allowed-origins = [ "https://cockpit.mmkaram.dev" ];
    settings = {
      WebService = {
        AllowUnencrypted = true;
      };
    };
  };
}
