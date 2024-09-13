{ config, pkgs, ... }:

{
  home.username = "dd0k";
  home.homeDirectory = "/home/dd0k";
  home.stateVersion = "24.05";

  home.packages = [
    # Add other packages here if needed
  ];

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
        nix-delete-builds="sudo nix-collect-garbage --delete-older-than";

      # TODO:
      # jump doesn't work because sourcing?
      jump="autojump";
      cls="clear";
      r="ranger";
      py="python3";
      el="eza -al";
      sp="spotify_player";
      ff="fastfetch";
      n="nvim";
      sn="sudo nvim";

      hibernate="systemctl hibernate";
    };
    initExtra = ''
      export PROG="/home/dd0k/prog"
      export NIX="/etc/nixos"
      # alias f="nvim $(fzf -m --preview="bat --color=always {}")"
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
    theme = "Dracula";
    keybindings = {
      "f11" = "toggle_fullscreen";
      "ctrl+shift+left" = "previous_window";
      "ctrl+shift+right" = "next_window";
    };
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

programs.neovim = {
  enable = true;
  plugins = with pkgs.vimPlugins; [
    mason-nvim
    mason-lspconfig-nvim
    nvim-lspconfig
    telescope-nvim
    plenary-nvim  # Required dependency for Telescope
    nvim-cmp
    cmp-nvim-lsp
    cmp-buffer
    cmp-path
    cmp-cmdline
    cmp-cmdline-history

    {
      plugin = tokyonight-nvim;
      config = "colorscheme tokyonight-night";
    }
  ];
extraConfig = ''
  lua << EOF
    -- Setup Mason
    require('mason').setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        },
        border = "rounded",
      },
    })

    -- Setup Mason-LSPConfig
    require('mason-lspconfig').setup({
      -- List your desired LSPs here
      ensure_installed = {}, 
      automatic_installation = true,
    })

    -- Setup Telescope
    local telescope = require('telescope')
    telescope.setup{}

    -- Keybindings for Telescope
    vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { noremap = true, silent = true })

    -- Keybindings for Mason UI
    vim.api.nvim_set_keymap('n', '<leader>m', '<cmd>Mason<cr>', { noremap = true, silent = true })


    set number
    set relativenumber

    " Macros for commenting and uncommenting lines
    let @v = "I#<Esc>j"
    let @c = "I//<Esc>j"
    let @f = "^xj"
    let @d = "^xxj"

  EOF
'';
};


  programs.tmux = {
    enable = true;
    extraConfig = ''
      set -g prefix C-x
      unbind C-z
      bind C-x send-prefix
    '';
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

