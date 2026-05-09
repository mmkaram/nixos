{ config, pkgs, ... }:
{
  services.nextcloud = {
    enable = true;
    hostName = "localhost";
    https = false;
    package = pkgs.nextcloud32;

    config = {
      adminpassFile = config.age.secrets.nextcloud.path;
      dbtype = "sqlite";
    };
  };

  services.nginx.virtualHosts."${config.services.nextcloud.hostName}".listen = [
    {
      addr = "127.0.0.1";
      port = 7645;
    }
  ];
}
