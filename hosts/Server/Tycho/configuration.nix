{
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../Common/configuration.nix
    ./wiki.nix
    ./torrent.nix
    ./sonarr.nix
    ./radarr.nix
    ./lidarr.nix
    ./readarr.nix
    ./prowlarr.nix
    ./homepage.nix
    ./vaultwarden.nix
    ./microbin.nix
    # inputs.home-manager.nixosModules.default
  ];

  networking.hostName = "Tycho";

  services.openssh.enable = true;

  services.getty.autologinUser = "dd0k";

  users.users.mh0 = {
    isNormalUser = true;
    description = "Mohammed Karam";
    extraGroups = [
      "users"
      "networkmanager"
      "docker"
      "libvirtd"
    ];
    packages = with pkgs; [
      git
      fish
      just
      neovim
    ];
  };

  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };
  environment.systemPackages = with pkgs; [
    python3
    # jf
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
  ];

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

    settings = {
      service = {
        DISABLE_REGISTRATION = true;
      };
      server = {
        DOMAIN = "git.mmkaram.dev"; # external hostname
        ROOT_URL = "https://git.mmkaram.dev/"; # public URL
        HTTP_ADDR = "127.0.0.1";
        HTTP_PORT = 3000;

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

  services.atuin = {
    enable = true;

    host = "127.0.0.1";
    port = 8888;
    openFirewall = false;

    openRegistration = false;

    path = "/var/lib/atuin";

    database = {
      createLocally = true;
    };
  };

  services.uptime-kuma = {
    enable = true;
    settings = {
      PORT = "3001";
    };
  };

  services.immich = {
    enable = true;
    port = 2283;
  };

  services.audiobookshelf.enable = true;

  services.cloudflared = {
    enable = true;

    tunnels.tycho = {
      credentialsFile = "/run/agenix/tycho";

      ingress = {
        "home.mmkaram.dev" = "http://127.0.0.1:3002";
        "git.mmkaram.dev" = "http://127.0.0.1:3000";
        "navidrome.mmkaram.dev" = "http://127.0.0.1:4533";
        "jellyfin.mmkaram.dev" = "http://127.0.0.1:8096";
        "atuin.mmkaram.dev" = "http://127.0.0.1:8888";
        "status.mmkaram.dev" = "http://127.0.0.1:3001";
        "wiki.mmkaram.dev" = "http://127.0.0.1:8089";
        "qbt.mmkaram.dev" = "http://127.0.0.1:8080";
        "sonarr.mmkaram.dev" = "http://127.0.0.1:8989";
        "readarr.mmkaram.dev" = "http://127.0.0.1:8787";
        "prowlarr.mmkaram.dev" = "http://127.0.0.1:9696";
        "lidarr.mmkaram.dev" = "http://127.0.0.1:8686";
        "radarr.mmkaram.dev" = "http://127.0.0.1:7878";
        "immich.mmkaram.dev" = "http://[::1]:2283";
        "vault.mmkaram.dev" = "http://127.0.0.1:8222";
        "audiobook.mmkaram.dev" = "http://127.0.0.1:8000";
        "bin.mmkaram.dev" = "http://127.0.0.1:9090";
      };

      default = "http_status:404";
    };
  };
}
