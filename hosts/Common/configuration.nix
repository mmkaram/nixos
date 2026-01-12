{
  pkgs,
  config,
  ...
}:
{
  # Nix settings
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [ ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Automount
  services.udisks2.enable = true;
  services.gvfs.enable = true;

  # Time/Locale
  services.automatic-timezoned.enable = true;
  i18n.defaultLocale = "en_US.UTF-8";

  # Users
  users.users.dd0k = {
    isNormalUser = true;
    description = "dD0k";
    hashedPasswordFile = config.age.secrets.password.path;
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
      git
      fish
    ];
  };
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;
  programs.zsh.enable = true;

  # Services
  services.kanata = import ../../dots/kanata/kanata.nix { };
  virtualisation.docker.enable = true;
  services.openssh.enable = true;

  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };

  services.pcscd.enable = true;
  services.udev.packages = [ pkgs.yubikey-personalization ];

  security.pam.u2f = {
    enable = true;
    settings = {
      interactive = true;
      cue = true;
      authFile = "/etc/nixos/secrets/u2f_keys";
    };
  };

  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    settings.disable-scdaemon = true;
  };

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
  ];

  # Age
  age = import ../../secrets/age.nix;

  system.stateVersion = "24.11";
}
