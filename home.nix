{
  home,
  config,
  pkgs,
  inputs,
  ...
}: {
  home.username = "dd0k";
  home.homeDirectory = "/home/dd0k";
  home.stateVersion = "24.05";

  accounts.email = {
    accounts.Kernel = {
      primary = true;
      userName = "mahdymkaram@gmail.com";
      realName = "Mahdy Karam";
      flavor = "gmail.com";
      imap = {
        host = "imap.gmail.com";
        port = 993;
        tls = {
          enable = true;
          useStartTls = false;
        };
      };
      smtp = {
        host = "smtp.gmail.com";
        port = 587;
        tls = {
          enable = true;
          useStartTls = true;
        };
      };
      mbsync = {
        enable = true;
        create = "maildr";
      };
      msmtp.enable = true;
      notmuch.enable = true;
      address = "mahdymkaram@gmail.com";
    };
  };

  home.packages = [
    pkgs.rofi-wayland
    pkgs.starship
    pkgs.oh-my-fish
    pkgs.swaybg
    pkgs.dmenu
    pkgs.playerctl
    pkgs.shotman
    pkgs.fd
    pkgs.sway-audio-idle-inhibit
    pkgs.waybar
    pkgs.libappindicator-gtk3
    pkgs.nitch
  ];

  imports = [
    ./sway/waybar.nix
  ];

  wayland.windowManager.sway = {
    enable = true;
    checkConfig = false;
    config = rec {
      modifier = "Mod4";
      terminal = "kitty";
      bars = [
        {
          command = "${pkgs.waybar}/bin/waybar";
        }
      ];
      gaps = {
        inner = 5;
        outer = 5;
      };
      window = {
        border = 2;
        titlebar = true;
      };
      input = {
        "type:touchpad" = {
          natural_scroll = "enabled";
          pointer_accel = "0.1";
          accel_profile = "flat";
          tap = "enabled";
          scroll_factor = "0.2";
        };
        "type:pointer" = {
          accel_profile = "flat";
          pointer_accel = "0.1";
          scroll_factor = "0.2";
        };
      };
      output = {
        "*" = {
          bg = "/etc/nixos/misc/Nix.png fill";
        };
      };
      startup = [
        {
          command = ''
            swaybar
          '';
        }
      ];
      keybindings = import ./sway/keybindings.nix {pkgs = pkgs;};
    };
    extraConfig = ''
      exec "sway-audio-idle-inhibit"
      exec "swayidle timeout 420 'swaylock -c 145874' timeout 660 'systemctl sleep' timeout 900 'systemctl suspend-then-hibernate'"
    '';
  };

  services.dunst = {
    enable = true;
  };

  programs.fish = import ./dots/fish/fish.nix;

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    theme = "Arc-Dark";
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableTransience = true;
  };

  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    themeFile = "tokyo_night_night";
    font.package = pkgs.fira-code;
    font.name = "FiraCode";
    keybindings = {
      "f11" = "toggle_fullscreen";
      "ctrl+shift+left" = "previous_window";
      "ctrl+shift+right" = "next_window";
    };
    extraConfig = ''
      cursor_trail 9
    '';
  };

  programs.tmux = import ./dots/tmux/tmux.nix {inherit pkgs;};

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.ranger = {
    enable = true;
    mappings = {
      dD = "delete";
    };
    extraConfig = ''
      set preview_images true
      set preview_images_method kitty
    '';
  };

  programs.git = {
    enable = true;
    userName = "mmkaram";
    userEmail = "mahdykaram@outlook.com";
    extraConfig.init = {
      defaultBranch = "main";
      safe.directory = "/etc/nixos";
      push.autoSetupRemote = true;
    };
  };

  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host csuw
          HostName linux.student.cs.uwaterloo.ca
          User mkaram
          ForwardX11Trusted yes
      Host hfcs
          HostName hfcs.csclub.uwaterloo.ca
          User mkaram
      Host corn-syrup
          HostName corn-syrup.csclub.uwaterloo.ca
          User mkaram
      host prod
          hostname 172.19.134.119
          proxyjump corn-syrup
          user ubuntu
    '';
  };

  programs.vim = {
    enable = true;
    # defaultEditor = true;
    plugins = with pkgs.vimPlugins; [vim-airline jedi-vim nerdtree];
    settings = {ignorecase = true;};
    extraConfig = ''
      set mouse=a

      set number
      set relativenumber
    '';
  };

  programs.neovim = import ./nvim/nvim.nix {inherit pkgs;};

  programs.spotify-player = {
    enable = true;
    settings = {
      client_id = "d5d01a282d5d475f8edf35dd5aab6b55";
      enable_notify = false;
      device = {
        volume = 100;
        name = "term";
        normalization = false;
      };
    };
  };

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "tokyo-night";
    };
  };

  programs.atuin = {
    enable = true;
  };

  home.file = {
    ".config/iamb/config.toml".source = ./dots/iamb/config.toml;
    ".config/ghostty/config".source = ./dots/ghostty/config;
  };

  home.sessionVariables = {
  };

  programs.home-manager.enable = true;

  # Dark mode
  dconf.settings = {
    "org/gnome/desktop/background" = {
      picture-uri-dark = "file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.src}";
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };
}
