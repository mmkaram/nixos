{
  pkgs,
  inputs,
  config,
  ...
}:
{

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Programs
  environment.systemPackages = import ../Common/programs.nix { inherit pkgs inputs; };

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Automount
  services.udisks2.enable = true;
  services.gvfs.enable = true; # For integration with file managers

  # services
  services.automatic-timezoned.enable = true;
  i18n.defaultLocale = "en_US.UTF-8";
  # Enable openGL
  hardware.graphics.enable = true;

  # Brightness and volume
  programs.light.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  # printing gui
  programs.system-config-printer.enable = true;
  # Avahi for mDNS
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Enable sound with pipewire.
  # sound.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    #jack.enable = true;
  };

  ##########################################
  #  _   _   ____    _____   ____    ____  #
  # | | | | / ___|  | ____| |  _ \  / ___| #
  # | | | | \___ \  |  _|   | |_) | \___ \ #
  # | |_| |  ___) | | |___  |  _ <   ___) |#
  #  \___/  |____/  |_____| |_| \_\ |____/ #
  ##########################################
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
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    backupFileExtension = "backup";
    users = {
      "dd0k" = import (../${config.networking.hostName}/home.nix);
    };
  };

  #####################################################################
  #  ____    ____     ___     ____   ____       _      __  __   ____  #
  # |  _ \  |  _ \   / _ \   / ___| |  _ \     / \    |  \/  | / ___| #
  # | |_) | | |_) | | | | | | |  _  | |_) |   / _ \   | |\/| | \___ \ #
  # |  __/  |  _ <  | |_| | | |_| | |  _ <   / ___ \  | |  | |  ___) |#
  # |_|     |_| \_\  \___/   \____| |_| \_\ /_/   \_\ |_|  |_| |____/ #
  #####################################################################
  # Programs
  # Enable insecure and unfree packages
  nixpkgs.config.permittedInsecurePackages = [ ];
  nixpkgs.config.allowUnfree = true;

  # Enable nix-ld
  programs.nix-ld.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };

  services.kanata = import ../../dots/kanata/kanata.nix { };

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
  # services
  # ios usb tethering
  services.usbmuxd.enable = true;

  # Enable Docker
  virtualisation.docker.enable = true;

  # Virtualization
  services.qemuGuest.enable = true;
  programs.virt-manager.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
    };
  };

  # age secrets manager
  age = import ../../secrets/age.nix;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable localsend
  programs.localsend.enable = true;
  programs.localsend.openFirewall = true;

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

  # Allow 16MB for max perf locked memory
  boot.kernel.sysctl = {
    "kernel.perf_event_mlock_kb" = 16 * 1024;
  };

  # Enbale auto garbage collection
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  system.stateVersion = "24.11";
}
