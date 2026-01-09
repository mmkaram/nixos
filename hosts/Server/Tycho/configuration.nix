{
  inputs,
  config,
  pkgs,
  ...
}:
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  imports = [
    ./hardware-configuration.nix
    # inputs.home-manager.nixosModules.default
  ];

  networking.hostName = "Tycho";
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  # Network proxy Confugration
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # age secrets manager
  # age = import ../../secrets/age.nix;

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Automount
  services.udisks2.enable = true;
  services.gvfs.enable = true; # For integration with file managers

  # services
  services.automatic-timezoned.enable = true;
  i18n.defaultLocale = "en_US.UTF-8";

  # Users
  users.users.dd0k = {
    isNormalUser = true;
    description = "dD0k";
    hashedPasswordFile = config.age.secrets.password.path;
    # Groups
    # esp32: dialout, uucp
    # wireshark: wireshark
    # docker: docker
    # virt-man: libvirtd
    extraGroups = [
      "users"
      "networkmanager"
      "wheel"
      "docker"
      "video"
      "libvirtd"
      "dialout"
      "uucp"
      "wireshark"
    ];
    packages = with pkgs; [
      firefox
      zoom-us
    ];
  };

  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;
  programs.zsh.enable = true;
  # home-manager = {
  #   extraSpecialArgs = { inherit inputs; };
  #   backupFileExtension = "backup";
  #   users = {
  #     "dd0k" = import (../${config.networking.hostName}/home.nix);
  #   };
  # };

  # Programs
  # Enable insecure and unfree packages
  nixpkgs.config.permittedInsecurePackages = [ ];
  nixpkgs.config.allowUnfree = true;

  services.kanata = import ../../../dots/kanata/kanata.nix { };

  # FONTS
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
  ];

  ##################################################################
  #  ____    _____   ____   __     __  ___    ____   _____   ____  #
  # / ___|  | ____| |  _ \  \ \   / / |_ _|  / ___| | ____| / ___| #
  # \___ \  |  _|   | |_) |  \ \ / /   | |  | |     |  _|   \___ \ #
  #  ___) | | |___  |  _ <    \ V /    | |  | |___  | |___   ___) |#
  # |____/  |_____| |_| \_\    \_/    |___|  \____| |_____| |____/ #
  ##################################################################

  # Enable Docker
  virtualisation.docker.enable = true;

  # age secrets manager
  age = import ../../../secrets/age.nix;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable mullvad vpn
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };

  # yubikey/yubico
  services.pcscd.enable = true;
  services.udev.packages = [ pkgs.yubikey-personalization ];

  security.pam.u2f = {
    enable = true;
    # control = "required";
    settings = {
      interactive = true;
      cue = true;
      authFile = "/etc/nixos/secrets/u2f_keys";
    };
  };

  security.pam.services = {
    login = {
      u2fAuth = true;
      # unixAuth = false;
    };
    sudo = {
      u2fAuth = true;
      # unixAuth = false;
    };
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    settings = {
      disable-scdaemon = true;
    };
  };

  system.stateVersion = "24.11";
}
