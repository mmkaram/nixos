{ config, pkgs, ... }:
{
  services.nextcloud = {
    enable = true;
    hostName = "nextcloud.mmkaram.dev";
    https = false;
    package = pkgs.nextcloud32;

    config = {
      adminpassFile = config.age.secrets.nextcloud.path;
      dbtype = "sqlite";
    };

    settings = {
      trusted_domains = [ "nextcloud.mmkaram.dev" ];
      overwriteprotocol = "https";
      "overwrite.cli.url" = "https://nextcloud.mmkaram.dev";
    };

    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps)
        news
        contacts
        calendar
        tasks
        ;
    };
    extraAppsEnable = true;
  };

  services.nginx.virtualHosts."${config.services.nextcloud.hostName}".listen = [
    {
      addr = "127.0.0.1";
      port = 7645;
    }
  ];
}
