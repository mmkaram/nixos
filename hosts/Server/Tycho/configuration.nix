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

  services.tailscale = {
    enable = true;
    #authKeyFile = "/run/secrets/tailscale_key";
  };

  # skip intro plugin
  # https://wiki.nixos.org/wiki/Jellyfin#:~:text=Intro%20Skipper%20plugin,-The
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
    environmentFile = ./navidrome.toml;
  };

  # Gitea
  services.gitea = {
    enable = true;

    # Bind only locally; put nginx or cloudflared in front
    appName = "Gitea";
    domain = "git.mmkaram.dev"; # external hostname
    rootUrl = "https://git.mmkaram.dev/"; # public URL
    httpAddress = "127.0.0.1";
    httpPort = 3000;

    # Auth + user bootstrap
    disableRegistration = false; # set to false for first user if needed
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

      # SQLite by default (zero-maintenance)
      database = {
        DB_TYPE = "sqlite3";
        # PATH = "gitea.db";
      };

      # Basic email stub (optional; wire real SMTP later)
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
      credentialsFile =
        "/etc/nixos/hosts/Server/Tycho/cloudflared/tycho.json";

      ingress = {
        "git.mmkaram.dev" = "http://127.0.0.1:3000";
      };

      default = "http_status:404";
    };
  };
}
