{ config, pkgs, ... }:

{
  home.username = "dd0k";
  home.homeDirectory = "/home/dd0k";
  home.stateVersion = "24.05";

  home.packages = [
    pkgs.dmenu
    pkgs.playerctl
    pkgs.shotman
    pkgs.fd
    pkgs.sway-audio-idle-inhibit
    pkgs.wofi
  ];

  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      terminal = "kitty";
      input = {
        "type:touchpad" = {
          natural_scroll = "enabled";  
          tap = "enabled";
        };
      };
      startup = [
        # Launch Firefox on start
        { command = ''
          exec --no-startup-id kitty --name scratchkitty
          for_window [title="scratchkitty"] move scratchpad
          '';
        }
      ];
      keybindings = {
        "Mod4+Shift+d" = "exec ${pkgs.dmenu}/bin/dmenu_path | ${pkgs.dmenu}/bin/dmenu | ${pkgs.findutils}/bin/xargs swaymsg exec --";
        "Mod4+d"="exec 'wofi --show drun'";
        "Mod4+Return" = "exec kitty tmux";
        "Mod4+Shift+Return" = "exec kgx";
        "Mod4+Shift+S" = "exec 'systemctl hibernate'";
        "Mod4+Apostrophe" = "exec 'swaylock -c 145874 & systemctl suspend-then-hibernate'";
        "Mod4+Semicolon"="exec 'swaylock -c 145874'";
        # "Mod4+F"="exec 'ranger'";

        # vol
        "Alt+Shift+Equal" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "Alt+Shift+Minus" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMute" = "exec 'pactl set-sink-mute @DEFAULT_SINK@ toggle'";
        "Alt+Down" = "exec 'playerctl play-pause'";
        "XF86AudioPlay" = "exec 'playerctl play-pause'";
        "Alt+Page_Down" = "exec 'playerctl next'";
        "Alt+Page_Up" = "exec 'playerctl previous'";


        # bright
        "XF86MonBrightnessDown" = "exec 'brightnessctl set 5%-'";
        "XF86MonBrightnessUp" =   "exec 'brightnessctl set 5%+'";
        "Alt+Shift+9" = "exec 'brightnessctl set 5%-'";
        "Alt+Shift+0" = "exec 'brightnessctl set 5%+'";

        # screen
        "Print" = "exec 'shotman --capture region'";

        # New keybindings
        "Mod4+0" = "workspace number 10";
        "Mod4+1" = "workspace number 1";
        "Mod4+2" = "workspace number 2";
        "Mod4+3" = "workspace number 3";
        "Mod4+4" = "workspace number 4";
        "Mod4+5" = "workspace number 5";
        "Mod4+6" = "workspace number 6";
        "Mod4+7" = "workspace number 7";
        "Mod4+8" = "workspace number 8";
        "Mod4+9" = "workspace number 9";
        "Mod4+Down" = "focus down";
        "Mod4+Left" = "focus left";
        "Mod4+Right" = "focus right";
        "Mod4+Shift+0" = "move container to workspace number 10";
        "Mod4+Shift+1" = "move container to workspace number 1";
        "Mod4+Shift+2" = "move container to workspace number 2";
        "Mod4+Shift+3" = "move container to workspace number 3";
        "Mod4+Shift+4" = "move container to workspace number 4";
        "Mod4+Shift+5" = "move container to workspace number 5";
        "Mod4+Shift+6" = "move container to workspace number 6";
        "Mod4+Shift+7" = "move container to workspace number 7";
        "Mod4+Shift+8" = "move container to workspace number 8";
        "Mod4+Shift+9" = "move container to workspace number 9";
        "Mod4+Shift+Down" = "move down";
        "Mod4+Shift+Left" = "move left";
        "Mod4+Shift+Right" = "move right";
        "Mod4+Shift+Up" = "move up";
        "Mod4+Shift+c" = "reload";
        "Mod4+Shift+e" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";
        "Mod4+Shift+h" = "move left";
        "Mod4+Shift+j" = "move down";
        "Mod4+Shift+k" = "move up";
        "Mod4+Shift+l" = "move right";
        "Mod4+Shift+minus" = "move scratchpad";
        "Mod4+Shift+q" = "kill";
        "Mod4+Shift+space" = "floating toggle";
        "Mod4+Up" = "focus up";
        "Mod4+a" = "focus parent";
        "Mod4+b" = "splith";
        "Mod4+e" = "layout toggle split";
        "Mod4+f" = "fullscreen toggle";
        "Mod4+h" = "focus left";
        "Mod4+j" = "focus down";
        "Mod4+k" = "focus up";
        "Mod4+l" = "focus right";
        "Mod4+minus" = "scratchpad show";
        "Mod4+r" = "mode resize";
        "Mod4+s" = "layout stacking";
        "Mod4+space" = "focus mode_toggle";
        "Mod4+v" = "splitv";
        "Mod4+w" = "layout tabbed";
        "Mod4+Ctrl+Left" = "workspace prev";
        "Mod4+Ctrl+Right" = "workspace next";
      };
      };
      extraConfig = ''
        exec "sway-audio-idle-inhibit"
        exec "swayidle timeout 420 'swaylock -c 145874' timeout 660 'systemctl sleep' timeout 900 'systemctl suspend-then-hibernate'"
      '';
  };


  programs.bash = {
    enable = true;
    shellAliases = {
      gc="git commit -a -m";
      gP="git push";
      gp="git pull";
      ga="git add .";
      gitgraph="git log --online --graph --decorate -all";
      lgit="lazygit";
      ldoc="lazydocker";
      t="tmux";
      icat="kitten icat";
      salah="bash ~/prog/salah";

      tetris="bastet";
      space_invaders="nivaders";
      snake="nsnake";

	nix-rebuild="sudo nixos-rebuild switch --flake /etc/nixos#default";
        nix-update="cd /etc/nixos && sudo nix flake update";
        nix-delete-older-than="sudo nix-collect-garbage --delete-older-than ";
        nix-delete="sudo nix-collect-garbage --delete-old"; #--delete-older-than

      # TODO:
      # jump doesn't work because sourcing?
      jump="autojump";
      cls="clear";
      r="ranger";
      py="python3";
      el="eza --git-repos -h -l -all";
      sp="spotify_player";
      ff="fastfetch";
      n="nvim";
      sn="sudo nvim";
      map="telnet mapscii.me";

      hibernate="systemctl hibernate";
    };
    initExtra = ''
      export PROG="/home/dd0k/prog"
      export NIX="/etc/nixos"
      # alias f="nvim $(fzf -m --preview="bat --color=always {}")"
      # This doesn't work (direnv breaking history bash)
      # eval "$(direnv hook bash)"
      '';
  };

  programs.oh-my-posh = {
    enable = true;
    enableBashIntegration = true;
    useTheme = "material";
  };

  programs.kitty = {
    enable = true;
    shellIntegration.enableBashIntegration = true;
    themeFile = "Dracula";
    font.name = "FiraCode Nerd Font Mono, Medium";
    keybindings = {
      "f11" = "toggle_fullscreen";
      "ctrl+shift+left" = "previous_window";
      "ctrl+shift+right" = "next_window";
    };
  };

  programs.tmux = {
    enable = true;
    # prefix = "C-f";
    extraConfig = '' 
      setw -g mouse on
      setw -g mode-keys vi
      unbind MouseDragEnd1Pane
    '';
  };

  programs.ranger = {
    enable = true;
    mappings = { 
      dD = "delete";
    };
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
Host hfcs
    HostName hfcs.csclub.uwaterloo.ca
    User mkaram
Host corn-syrup
    HostName corn-syrup.csclub.uwaterloo.ca
    User mkaram
Host real1
    HostName 172.19.134.37
    ProxyJump corn-syrup
    User ubuntu
Host PerfTest2
    HostName 172.19.134.117
    ProxyJump corn-syrup
    User ubuntu
    '';
  };

  programs.vim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [ vim-airline jedi-vim nerdtree ];
    settings = { ignorecase = true; };
    extraConfig = ''
      set mouse=a

      set number
      set relativenumber

      " Macros for commenting and uncommenting lines
      let @v = "I#<Esc>j"
      let @c = "I//<Esc>j"
      let @f = "^xj"
      let @d = "^xxj"
    '';
  };

  programs.neovim =
  let 
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in
  {
  enable = true;

  plugins = with pkgs.vimPlugins; [

    {
      plugin = tokyonight-nvim;
      config = "colorscheme tokyonight";
    }


    nvim-lspconfig # uhh, lsp stuff

    {
      plugin = comment-nvim;
      config = toLua "require(\"Comment\").setup()";
    }

    lazydev-nvim # no clue, some lua thing

    {
      # LSP Server installer that works with lspconfig
      plugin = mason-nvim;
      config = toLua "require(\"mason\").setup()";
    }
    nvim-cmp # completion engine
    telescope-nvim

    (nvim-treesitter.withPlugins (p: [
      p.tree-sitter-nix
      p.tree-sitter-python
      p.tree-sitter-bash
      p.tree-sitter-lua
      p.tree-sitter-json
      p.tree-sitter-rust
    ]))

    vim-nix
  ];
  viAlias = true;
  vimAlias = true;
  vimdiffAlias = true;
#  extraLuaConfig = ''
#    -- ${builtins.readFile ./nvim/options.lua}
#  '';
};

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

  programs.atuin = { 
    enable = true;
  };

  home.file = {
    # Your dotfiles here
  };

  home.sessionVariables = {
    # Your environment variables here
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

