{ config, lib, pkgs, inputs, ... }:
{

  # enable expiremental nix features
   nix.settings.experimental-features = [ "nix-command" "flakes" ];

  imports =
    [
      ./hardware-configuration.nix
      ./programs.nix
	inputs.home-manager.nixosModules.default
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "Rocinante"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Canada/Eastern";
  # services.automatic-timezoned.enable = true;

  # Select internationalisation properties.
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
  # Enable bluetooth
  hardware.bluetooth.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the XFCE Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;
  programs.sway.enable = true;
  # bright and vol
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
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dd0k = {
    isNormalUser = true;
    description = "dD0k";
    extraGroups = [ "networkmanager" "wheel" "docker" "video" ];
    packages = with pkgs; [
      firefox
      zoom-us
    ];
  };
  users.users.testuser = {
    isNormalUser = true;
    home = "/home/testuser";
    shell = pkgs.bash; # You can also set this to another shell like pkgs.zsh
    description = "testuser";
    extraGroups = [ "wheel" ]; # Optional, add sudo access by adding to "wheel" group
  };
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;
  programs.zsh.enable = true;
  ## Text editing
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  services.kanata = {
    enable = true;
  };

  ## Gaming
  programs.steam = {
  	enable = true;
  	remotePlay.openFirewall = true;
  	dedicatedServer.openFirewall = true;
  };
  ## Insecure Packages
  nixpkgs.config.permittedInsecurePackages = [];
  nixpkgs.config.allowUnfree = true;
  
  home-manager = {
  	# also pass inputs to home-manager modules
  	extraSpecialArgs = { inherit inputs; };
  	backupFileExtension = "backup";
  	users = {
  		"dd0k" = import ./home.nix;
  	};
  };

  # keyboard remapping with kanata
  # caps and backspace switch
  services.kanata = {
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
    		caps bspc
    		bspc caps
                ralt C-x
  	)
      '';
    };
  };
  
  # fonts
  fonts.packages = with pkgs; [
  	(nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];


  # Auto optimization - delete old builds
  # nix = {
  #   settings.auto-optimize-store = true;
  #   gc = {
  #     automatic = true;
  #     dates = "weekly";
  #     options = "--delete-older-than 7d";
  #   };
  # };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };


  # Enabled (systemd) services
  # Enable Docker
  virtualisation.docker.enable = true;

  # Enable polkit security to open gparted
  # gparted must be opened from root user
  # security.polkit.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.qemuGuest.enable = true;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable direnv for auto running nix-shell
  programs.direnv.enable = false;

  boot.kernel.sysctl = {
    "kernel.perf_event_mlock_kb" = 16 * 1024;  # Set to 16MB
  };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?



}
