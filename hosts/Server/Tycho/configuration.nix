{
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../Common/configuration.nix
    ./torrent.nix
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
      MusicFolder = "/srv/library";
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

  services.mediawiki = {
    enable = true;
    name = "Karam Wiki";
    httpd.virtualHost = {
      hostName = "wiki.mmkaram.dev";
      adminAddr = "admin@mmkaram.dev"; # TODO
      listen = [
        {
          ip = "127.0.0.1";
          port = 8089;
          ssl = false;
        }
      ];
    };

    database = {
      type = "mysql";
      createLocally = true;
    };

    # Administrator account username is admin.
    # Set initial password to "cardbotnine" for the account admin.
    passwordFile = /run/agenix/mediawiki;
    extraConfig = ''
      # Disable anonymous editing
      $wgGroupPermissions['*']['edit'] = false;
      # Disable new user registration
      $wgGroupPermissions['*']['createaccount'] = false;
    '';

    extensions = {
      # some extensions are included and can enabled by passing null
      VisualEditor = null;

      # https://www.mediawiki.org/wiki/Extension:TemplateStyles
      TemplateStyles = pkgs.fetchzip {
        url = "https://extdist.wmflabs.org/dist/extensions/TemplateStyles-REL1_40-5c3234a.tar.gz";
        hash = "sha256-IygCDgwJ+hZ1d39OXuJMrkaxPhVuxSkHy9bWU5NeM/E=";
      };
    };
  };

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
      };

      default = "http_status:404";
    };
  };
}
