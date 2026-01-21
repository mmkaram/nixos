{
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../Common/configuration.nix
    # inputs.home-manager.nixosModules.default
  ];

  networking.hostName = "Tycho";

  services.openssh.enable = true;

  services.getty.autologinUser = "dd0k";

  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };
  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
  ];

  services.vaultwarden = {
    enable = true;
    backupDir = "/var/local/vaultwarden/backup";
    # in order to avoid having  ADMIN_TOKEN in the nix store it can be also set with the help of an environment file
    # be aware that this file must be created by hand (or via secrets management like sops)
    environmentFile = "/var/lib/vaultwarden/vaultwarden.env";
    config = {
      # Refer to https://github.com/dani-garcia/vaultwarden/blob/main/.env.template
      DOMAIN = "https://vaultwarden.mmkaram.dev";
      SIGNUPS_ALLOWED = false;

      ROCKET_ADDRESS = "127.0.0.1";
      ROCKET_PORT = 8222;
      ROCKET_LOG = "critical";

      # This example assumes a mailserver running on localhost,
      # thus without transport encryption.
      # If you use an external mail server, follow:
      #   https://github.com/dani-garcia/vaultwarden/wiki/SMTP-configuration
      # SMTP_HOST = "127.0.0.1";
      # SMTP_PORT = 25;
      # SMTP_SSL = false;
      #
      # SMTP_FROM = "admin@bitwarden.example.com";
      # SMTP_FROM_NAME = "example.com Bitwarden server";
    };
  };

  services.navidrome = {
    enable = true;

    settings = {
      MusicFolder = "/srv/library/music";
      DataFolder = "/srv/appdata/navidrome";

      ScanInterval = "1h";
      ScannerPurgeMissing = "always";
      SessionTimeout = "24h";
      LogLevel = "info";

      # Reverse proxy settings (for Cloudflare + your domain)
      BaseURL = "https://navidrome.mmkaram.dev";
      ReverseProxyListen = true;
      ReverseProxyClientIPHeaders = [ "CF-Connecting-IP" ];
      ReverseProxyTLS = true; # Matches TLS_TERMINATED=true

      # Disable auto-import playlists
      AutoImportPlaylists = false;

      # Cover art configuration
      CoverArtProviders = [
        "local"
        "embedded"
        "lastfm"
        "fanarttv"
        "coverartarchive"
      ];
      LastFM_APIKey = "aa2d579d4c6799e7d2977aca49baefc3";
      MusicBrainzEnabled = true;
      CoverArtPriority = "cover.jpg,cover.png,folder.jpg,folder.png,front.jpg,front.png,embedded";

      # Port
      ListenPort = 4533;
    };

    # ? Match Docker user/group (1000:100)
    user = "1000";
    group = "100";

    # Open firewall
    openFirewall = true;
  };

  # Gitea
  services.gitea = {
    enable = true;

    appName = "Gitea";
    domain = "git.mmkaram.dev"; # external hostname
    rootUrl = "https://git.mmkaram.dev/"; # public URL
    httpAddress = "127.0.0.1";
    httpPort = 3000;

    disableRegistration = true;
    settings = {
      server = {
        PROTOCOL = "http";
        SSH_DOMAIN = "tycho";
        SSH_PORT = 22; # host sshd
        START_SSH_SERVER = false; # use host OpenSSH, not Gitea’s internal
        LANDING_PAGE = "explore";
      };

      security = {
        INSTALL_LOCK = true; # skip installer once configured
      };

      database = {
        DB_TYPE = "sqlite3";
        # PATH = "gitea.db";
      };

      # Basic email stub
      email = {
        ENABLED = false;
      };
    };

    # Data lives here: repos, config, avatars, etc.
    stateDir = "/var/lib/gitea";
  };

  services.cloudflared = {
    enable = true;

    tunnels.tycho = {
      credentialsFile = "/run/agenix/tycho";

      ingress = {
        "git.mmkaram.dev" = "http://127.0.0.1:3000";
        "navidrome.mmkaram.dev" = "http://127.0.0.1:4533";
        "jellyfin.mmkaram.dev" = "http://127.0.0.1:8096";
      };

      default = "http_status:404";
    };
  };
}
