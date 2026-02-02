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
          {
            Prowlarr = {
              href = "https://prowlarr.mmkaram.dev";
              description = "Tracker manager";
            };
          }
          {
            Sonarr = {
              href = "https://sonarr.mmkaram.dev";
              description = "TV Tracker";
            };
          }
          {
            Lidarr = {
              href = "https://lidarr.mmkaram.dev";
              description = "Music Tracker";
            };
          }
          {
            Radarr = {
              href = "https://radarr.mmkaram.dev";
              description = "Movie Tracker";
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
          {
            Immich = {
              href = "https://immich.mmkaram.dev";
              description = "Photos";
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
