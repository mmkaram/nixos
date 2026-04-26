{
  pkgs,
  config,
  inputs,
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
    ./navidrome.nix
    ./jellyfin.nix
    ./gitea.nix
    ./atuin.nix
    inputs.nix-dokploy.nixosModules.dokploy
    # inputs.home-manager.nixosModules.default
  ];

  networking.hostName = "Tycho";

  services.openssh.enable = true;

  services.getty.autologinUser = "dd0k";

  environment.systemPackages = with pkgs; [
    powertop
    linuxKernel.packages.linux_6_12.turbostat
    smartmontools
    tmux
    lazygit
    rtorrent
    neovim
    just
    btop
    duf
    ffmpeg
    fzf
    cloudflared
    wget
    eyed3
  ];

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

  virtualisation.docker.enable = true;
  virtualisation.docker.daemon.settings.live-restore = false;

  services.dokploy = {
    enable = true;

    database.passwordFile = "/var/lib/secrets/dokploy-db-password";

    port = "3001:3000";
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
    mediaLocation = "/srv/library/images";
  };

  services.audiobookshelf.enable = true;

  services.cloudflared = {
    enable = true;

    tunnels.tycho = {
      credentialsFile = config.age.secrets.tycho.path;

      ingress = {
        "home.mmkaram.dev" = "http://127.0.0.1:3002";
        "git.mmkaram.dev" = "http://127.0.0.1:3000";
        "navidrome.mmkaram.dev" = "http://127.0.0.1:4533";
        "jellyfin.mmkaram.dev" = "http://127.0.0.1:8096";
        "atuin.mmkaram.dev" = "http://127.0.0.1:8888";
        "status.mmkaram.dev" = "http://127.0.0.1:3001";
        "wiki.mmkaram.dev" = "http://127.0.0.1:8089";
        "qbt.mmkaram.dev" = "http://10.200.200.2:8080";
        "sonarr.mmkaram.dev" = "http://127.0.0.1:8989";
        "readarr.mmkaram.dev" = "http://127.0.0.1:8787";
        "prowlarr.mmkaram.dev" = "http://127.0.0.1:9696";
        "lidarr.mmkaram.dev" = "http://127.0.0.1:8686";
        "radarr.mmkaram.dev" = "http://127.0.0.1:7878";
        "immich.mmkaram.dev" = "http://[::1]:2283";
        "vault.mmkaram.dev" = "http://127.0.0.1:8222";
        "audiobook.mmkaram.dev" = "http://127.0.0.1:8000";
        "bin.mmkaram.dev" = "http://127.0.0.1:9090";
        "dokploy.mmkaram.dev" = "http://127.0.0.1:3100";
      };

      default = "http_status:404";
    };
  };

  # RAID/Drive
  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = [ "/srv" ];
  };
  services.smartd = {
    enable = true;
    autodetect = true;
  };
  services.snapper = {
    configs.media = {
      SUBVOLUME = "/srv";
      TIMELINE_CREATE = true;
      TIMELINE_CLEANUP = true;
    };
  };
}
