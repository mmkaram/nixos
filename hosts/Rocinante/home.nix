{
  pkgs,
  inputs,
  ...
}:
{
  home.username = "dd0k";
  home.homeDirectory = "/home/dd0k";
  home.stateVersion = "25.11";

  imports = [
    inputs.agenix.homeManagerModules.default
  ];

  wayland.windowManager.hyprland = import ../../dots/hyprland/hyprland.nix { };
  programs.waybar = import ../../dots/hyprland/waybar.nix { };
  services.hyprpaper = import ../../dots/hyprland/hyprpaper.nix { };
  services.hypridle = import ../../dots/hyprland/hypridle.nix { };

  services.dunst.enable = true;

  programs.fish = import ../../dots/fish/fish.nix;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    theme = "Arc-Dark";
  };

  services.cliphist = {
    enable = true;
    package = pkgs.cliphist;
    allowImages = true;
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableTransience = true;
  };

  programs.kitty = import ../../dots/kitty/kitty.nix { inherit pkgs; };

  programs.tmux = import ../../dots/tmux/tmux.nix { inherit pkgs; };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.git = import ../../dots/git/git.nix { };

  programs.ssh = import ../../dots/ssh/ssh.nix { };

  programs.vim = {
    enable = true;
    extraConfig = ''
      set mouse=a
      set number
      set relativenumber
    '';
  };

  programs.neovim = import ../../dots/nvim/nvim.nix { inherit pkgs; };

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

  programs.atuin.enable = true;

  services.flameshot = {
    enable = true;
    settings = {
      General = {
        showStartupLaunchMessage = false;
        useGrimAdapter = true;
      };
    };
  };

  home.file = {
    ".config/ghostty/config".source = ../../dots/ghostty/config;
  };

  age.secrets = { };
  home.sessionVariables = { };

  programs.home-manager.enable = true;

  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true;
    package = pkgs.graphite-cursors;
    name = "graphite-dark";
    size = 16;
  };

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
