{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "dd0k";
  home.homeDirectory = "/home/dd0k";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

# program configs

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
    # useTheme = "kushal";
    useTheme = "material";
    # one day add transient prompt
    # (when they integrate it with bash)
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
          # default branch
          extraConfig.init = {
            defaultBranch = "main";
            safe.directory = "/etc/nixos";
          };
        };

  programs.vim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [ vim-airline jedi-vim nerdtree ];
    settings = { ignorecase = true; };
    extraConfig = ''
      set mouse=a
    '';
  };

  programs.neovim = { 
    enable = true;
    plugins = with pkgs.vimPlugins; [
      # mason-nvim
      lsp-zero-nvim
      nvim-cmp
      lazy-nvim

      telescope-nvim
      telescope-fzf-native-nvim
      lualine-nvim
      nvim-web-devicons
      (nvim-treesitter.withPlugins (p: [
        p.tree-sitter-nix
        p.tree-sitter-vim
        p.tree-sitter-python
      ])) # ;
      vim-nix

      nord-nvim
      {
      plugin = tokyonight-nvim;
      config = "colorscheme tokyonight-night";
      }
      # nvim-lspconfig
      neodev-nvim
    ];
    extraConfig = ''
      '';
  };


	programs.tmux = {
		enable = true;
                # mouse = true;
		extraConfig = ''
		# Change tmux prefix to Ctrl-a
                set -g prefix C-x
                unbind C-z
		bind C-x send-prefix

                # bind-key -n C-S-Left swap-window -t -1; select-window -t -1
                # bind-key -n C-S-Right swap-window -t +1; select-window -t +1

		'';
	};

	programs.spotify-player = {
		enable = true;
                settings= { 
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


  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/dd0k/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
