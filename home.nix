{ config, pkgs, ... }:

{
  home.username = "dd0k";
  home.homeDirectory = "/home/dd0k";
  home.stateVersion = "24.05";

  home.packages = [
    pkgs.starship
    pkgs.swaybg
    pkgs.dmenu
    pkgs.playerctl
    pkgs.shotman
    pkgs.fd
    pkgs.sway-audio-idle-inhibit
    pkgs.wofi
    pkgs.waybar
    pkgs.libappindicator-gtk3
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
      bars = [{
        command = "${pkgs.waybar}/bin/waybar";
      }];
      input = {
        "type:touchpad" = {
          natural_scroll = "enabled";  
          tap = "enabled";
        };
      };
      output = {
        "*" = {
          bg = "/etc/nixos/misc/Open.png fill";
        };
      };
      startup = [
        { command = ''
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


  programs.zsh = {
    enable = true;
    shellAliases = {
      copy = "wl-copy";

      gc="git commit -a -m";
      gP="git push";
      gp="git pull";
      ga="git add .";
      gitgraph="git log --online --graph --decorate -all";
      lgit="lazygit";
      ghd="gh-dash";
      ldoc="lazydocker";
      t="tmux";
      icat="kitten icat";

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
    defaultKeymap = "emacs";
    initExtra = ''
      export PROG="/home/dd0k/prog"
      export NIX="/etc/nixos"
      eval "$(direnv hook zsh)"
    '';
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      copy = "wl-copy";

      gc="git commit -a -m";
      gP="git push";
      gp="git pull";
      ga="git add .";
      gitgraph="git log --online --graph --decorate -all";
      lgit="lazygit";
      ghd="gh-dash";
      ldoc="lazydocker";
      t="tmux";
      icat="kitten icat";

      nix-rebuild="sudo nixos-rebuild switch --flake /etc/nixos#default";
      nix-update="cd /etc/nixos && sudo nix flake update";
      nix-delete-older-than="sudo nix-collect-garbage --delete-older-than ";
      nix-delete="sudo nix-collect-garbage --delete-old"; #--delete-older-than

      jump="autojump";
      cls="clear";
      r="ranger";
      py="python3";
      l="eza -lh";
      el="eza --git-repos -h -l -all";
      sp="spotify_player";
      ff="fastfetch";
      n="nvim";
      sn="sudo nvim";
      map="telnet mapscii.me";

      hibernate="systemctl hibernate";
    };
    shellInit = ''
      fish_vi_key_bindings
      # fish_default_key_bindings
      set -U fish_greeting
      set PROG "/home/dd0k/prog"
      set NIX "/etc/nixos"
      direnv hook fish | source
      '';
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
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
      # PROMPT_COMMAND="history -a; history -c; history -r; $_direnv_hook"
      '';
  };

  programs.oh-my-posh = {
    enable = true;
    # enableBashIntegration = true;
    enableZshIntegration = true;
    useTheme = "powerlevel10k_lean";
  };

  programs.kitty = {
    enable = true;
    # shellIntegration.enableBashIntegration = true;
    shellIntegration.enableZshIntegration = true;
    themeFile = "Dracula";
    font.package = pkgs.fira-code;
    font.name = "FiraCode";
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
      # Set the prefix key to Ctrl + X
      unbind C-b          # Unbind the default prefix (Ctrl + B)
      set -g prefix C-x   # Set new prefix to Ctrl + X
      bind C-x send-prefix # Allow sending prefix key
      
      # Start window numbering at 1 instead of 0
      set -g base-index 1 # Set base index for windows to 1
      set -g pane-base-index 1 # Set base index for panes to 1
      # set-option -g default-command "${pkgs.zsh}/bin/zsh"
      # set-option -g default-shell "${pkgs.zsh}/bin/zsh"
    '';
  };

  programs.autojump = {
    enable = true;
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
    # defaultEditor = true;
    plugins = with pkgs.vimPlugins; [ vim-airline jedi-vim nerdtree ];
    settings = { ignorecase = true; };
    extraConfig = ''
      set mouse=a

      set number
      set relativenumber
    '';
  };

  programs.neovim =
  let 
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in
  {
  enable = true;
  defaultEditor = true;

  plugins = with pkgs.vimPlugins; [
    
    # TODO:
    # alpha-lua
    # neo-tree
    # conform-nvim
    telescope-file-browser-nvim
    # deps
    plenary-nvim
    nvim-web-devicons
    nui-nvim

    vim-be-good

    quickfix-reflector-vim

    {
      plugin = dashboard-nvim;
      config = toLuaFile ./nvim/dash.lua;
    }

    {
      plugin = presence-nvim;
      config = toLuaFile ./nvim/presence.lua;
    }

    {
      plugin = indent-blankline-nvim;
      config = toLuaFile ./nvim/indent.lua;
    }

    {
      plugin = codewindow-nvim;
      config = toLuaFile ./nvim/codewindow.lua;
    }

    {
      plugin = zen-mode-nvim;
      config = toLuaFile ./nvim/maximize.lua;
    }

    {
      plugin = lazygit-nvim;
      config = toLuaFile ./nvim/lazygit.lua;
    }

    {
      plugin = undotree;
      config = toLuaFile ./nvim/undo.lua;
    }

    # gh cli integration
    {
      plugin = octo-nvim;
      config = toLuaFile ./nvim/octo.lua;
    }

    # lines changed since last commit
    {
      plugin = gitsigns-nvim;
      config = toLuaFile ./nvim/gitsigns.lua;
    }

    # status bar
    lualine-nvim
    {
      plugin = lualine-lsp-progress;
      config = toLuaFile ./nvim/lualine.lua;
    }

    {
      plugin = tokyonight-nvim;
      config = "colorscheme tokyonight-night";
    }

    {
      plugin = nvim-lspconfig;
      config = toLuaFile ./nvim/lsp.lua;
    }

    {
      plugin = comment-nvim;
      config = toLuaFile ./nvim/comment.lua;
    }

    {
      plugin = toggleterm-nvim;
      config = toLuaFile ./nvim/term.lua;
    }

    # tabs and stuff
    vim-unimpaired
    {
      plugin = bufferline-nvim;
      config = toLuaFile ./nvim/bufferline.lua;
    }

    {
      # idk how this is different from nvimp.cmp
      plugin = cmp-nvim-lsp;
      # this config isn't realted, it just loads 
      # keybinds because I can't source lua files from
      # other lua files
      config = toLuaFile ./nvim/keys.lua;
    }

    {
      plugin = nvim-cmp;
      config = toLuaFile ./nvim/completion.lua;
    }

    {
      plugin = telescope-nvim;
      config = toLuaFile ./nvim/telescope.lua;
    }

    # configured in telescope.lua
    telescope-ui-select-nvim

    (nvim-treesitter.withPlugins (p: [
      p.tree-sitter-nix
      p.tree-sitter-python
      p.tree-sitter-bash
      p.tree-sitter-lua
      p.tree-sitter-json
      p.tree-sitter-rust
      p.tree-sitter-haskell
      p.tree-sitter-c
      p.tree-sitter-cpp
    ]))

    vim-nix
  ];
  viAlias = true;
  vimAlias = true;
  vimdiffAlias = true;
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
