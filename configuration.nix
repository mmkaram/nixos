{
  pkgs,
  inputs,
  config,
  ...
}: {
  ##################################
  #  ____     ___     ____   ____  #
  # |  _ \   / _ \   / ___| / ___| #
  # | | | | | | | | | |     \___ \ #
  # | |_| | | |_| | | |___   ___) |#
  # |____/   \___/   \____| |____/ #
  ##################################
  # Docs
  # https://search.nixos.org/options
  ##############################
  #  ___   _   _   ___   _____ #
  # |_ _| | \ | | |_ _| |_   _|#
  #  | |  |  \| |  | |    | |  #
  #  | |  | |\  |  | |    | |  #
  # |___| |_| \_| |___|   |_|  #
  ##############################
  # Init
  # enable expiremental nix features (for flakes)
  nix.settings.experimental-features = ["nix-command" "flakes"];

  imports = [
    ./hardware-configuration.nix
    ./programs.nix
    inputs.home-manager.nixosModules.default
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Fingerprint
  services.fprintd = import ./dots/fprintd/fprintd.nix pkgs;

  ##############################################################
  #  _   _   _____   _____  __        __   ___    ____    _  __#
  # | \ | | | ____| |_   _| \ \      / /  / _ \  |  _ \  | |/ /#
  # |  \| | |  _|     | |    \ \ /\ / /  | | | | | |_) | | ' / #
  # | |\  | | |___    | |     \ V  V /   | |_| | |  _ <  | . \ #
  # |_| \_| |_____|   |_|      \_/\_/     \___/  |_| \_\ |_|\_\#
  ##############################################################
  # Network
  networking.hostName = "Rocinante";
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Network proxy Confugration
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  #################################################################################################
  #  _        ___     ____      _      _       ___   _____     _      _____   ___    ___    _   _ #
  # | |      / _ \   / ___|    / \    | |     |_ _| |__  /    / \    |_   _| |_ _|  / _ \  | \ | |#
  # | |     | | | | | |       / _ \   | |      | |    / /    / _ \     | |    | |  | | | | |  \| |#
  # | |___  | |_| | | |___   / ___ \  | |___   | |   / /_   / ___ \    | |    | |  | |_| | | |\  |#
  # |_____|  \___/   \____| /_/   \_\ |_____| |___| /____| /_/   \_\   |_|   |___|  \___/  |_| \_|#
  #################################################################################################
  # Localization
  time.timeZone = "America/Los_Angeles"; # "Afric/Cairo" "Canada/Eastern"
  # services.automatic-timezoned.enable = true;
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  #########################################################
  #  ____    _____   ____    _  __  _____    ___    ____  #
  # |  _ \  | ____| / ___|  | |/ / |_   _|  / _ \  |  _ \ #
  # | | | | |  _|   \___ \  | ' /    | |   | | | | | |_) |#
  # | |_| | | |___   ___) | | . \    | |   | |_| | |  __/ #
  # |____/  |_____| |____/  |_|\_\   |_|    \___/  |_|    #
  #########################################################
  # Desktop
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable openGL
  hardware.graphics.enable = true;

  # Enable desktop manager
  services.displayManager.ly.enable = true;
  programs.sway.enable = true;
  # Brightness and volume
  programs.light.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  # sound.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # For Jack programs:
    #jack.enable = true;

    #media-session.enable = true;
    wireplumber.enable = true;
  };

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

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
    extraGroups = ["users" "networkmanager" "wheel" "docker" "video" "libvirtd" "dialout" "uucp" "wireshark"];
    packages = with pkgs; [
      firefox
      zoom-us
    ];
  };
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;
  programs.zsh.enable = true;
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    backupFileExtension = "backup";
    users = {
      "dd0k" = import ./home.nix;
    };
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  #####################################################################
  #  ____    ____     ___     ____   ____       _      __  __   ____  #
  # |  _ \  |  _ \   / _ \   / ___| |  _ \     / \    |  \/  | / ___| #
  # | |_) | | |_) | | | | | | |  _  | |_) |   / _ \   | |\/| | \___ \ #
  # |  __/  |  _ <  | |_| | | |_| | |  _ <   / ___ \  | |  | |  ___) |#
  # |_|     |_| \_\  \___/   \____| |_| \_\ /_/   \_\ |_|  |_| |____/ #
  #####################################################################
  # Programs
  # Enable insecure Packages
  nixpkgs.config.permittedInsecurePackages = [];
  nixpkgs.config.allowUnfree = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };

  services.kanata = {
    enable = true;
    keyboards.default = {
      config = ''
            (defsrc
              grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
              tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
              caps a    s    d    f    g    h    j    k    l    ;    '    ret
              lsft z    x    c    v    b    n    m    ,    .    /    rsft
              lctl lmet lalt           spc            ralt prtsc rctl
            )
        (deflayermap (base-layer)
            caps esc
            esc caps
        )
      '';
    };
  };
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
      ovmf.enable = true;
    };
  };

  # Enable polkit security to open gparted
  # gparted must be opened from root user
  security.polkit.enable = true;

  # age secrets manager
  age = import ./secrets/age.nix;

  # yubikey/yubico
  services.pcscd.enable = true;
  services.udev.packages = [pkgs.yubikey-personalization];

  security.pam.u2f = {
    enable = true;
    authFile = "/etc/nixos/u2f_keys";
    settings = {
      interactive = true;
      cue = true;
    };
  };

  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Nix-ld to run unpatched dynamic binaries on NixOS
  programs.nix-ld.enable = true;

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

  ##################################################
  #  _   _   _   _   _   _   ____    _____   ____  #
  # | | | | | \ | | | | | | / ___|  | ____| |  _ \ #
  # | | | | |  \| | | | | | \___ \  |  _|   | | | |#
  # | |_| | | |\  | | |_| |  ___) | | |___  | |_| |#
  #  \___/  |_| \_|  \___/  |____/  |_____| |____/ #
  ##################################################
  # Unused
  # Auto optimization - delete old builds

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
}
