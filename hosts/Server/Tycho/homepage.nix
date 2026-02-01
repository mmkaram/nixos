{ ... }:
{
  services.homepage-dashboard = {
    enable = true;

    listenPort = 3002;
    allowedHosts = "home.mmkaram.dev";

    settings = {
      title = "Tycho";
      theme = "dark";
      color = "slate";
      headerStyle = "clean";
      hideVersion = true;
    };

    services = [
      {
        Arr = [
          {
            qBittorent = {
              href = "https://qbt.mmkaram.dev";
              description = "Torrenting client";
            };
          }
        ];
      }
      {
        Streaming = [
          {
            Jellyfin = {
              href = "https://jellyfin.mmkaram.dev";
              description = "Movies & TV";
            };
          }
          {
            Navidrome = {
              href = "https://navidrome.mmkaram.dev";
              description = "Music";
            };
          }
        ];
      }
      {
        Dev = [
          {
            Gitea = {
              href = "https://git.mmkaram.dev";
              description = "Git hosting";
            };
          }
        ];
      }
      {
        Infra = [
          {
            "Uptime Kuma" = {
              href = "https://status.mmkaram.dev";
              description = "Monitoring";
            };
          }
          {
            Atuin = {
              href = "https://atuin.mmkaram.dev";
              description = "Shell history sync";
            };
          }
        ];
      }
      {
        Security = [
          {
            Vaultwarden = {
              href = "https://vaultwarden.mmkaram.dev";
              description = "Password manager";
            };
          }
        ];
      }
      {
        Docs = [
          {
            Wiki = {
              href = "https://wiki.mmkaram.dev";
              description = "MediaWiki";
            };
          }
        ];
      }
    ];
  };

}
