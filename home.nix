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
      # keybindings = builtins.readFile ./sway/keybindings.txt;
      keybindings = import ./sway/keybindings.nix {pkgs = pkgs;};
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
    
    telescope-file-browser-nvim

    # deps
    plenary-nvim
    nvim-web-devicons
    nui-nvim

    octo-nvim

    {
      plugin = tokyonight-nvim;
      config = "colorscheme tokyonight";
    }

    {
      plugin = nvim-lspconfig;
      config = toLuaFile ./nvim/lsp.lua;
    }

    {
      plugin = comment-nvim;
      config = toLua "require(\"Comment\").setup()";
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

    lazydev-nvim # no clue, some lua thing

    cmp-nvim-lsp
    {
      plugin = nvim-cmp;
      config = toLuaFile ./nvim/completion.lua;
    }

    {
      plugin = telescope-nvim;
      config = toLuaFile ./nvim/telescope.lua;
    }

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
  # extraLuaConfig = toLua '''';
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
