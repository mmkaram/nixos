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
    ./navidrome.nix
    ./jellyfin.nix
    ./gitea.nix
    ./atuin.nix
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
