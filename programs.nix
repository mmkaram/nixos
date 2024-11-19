{pkgs, ... }:
# List packages installed in system profile. To search, run:
# $ nix search wget
let
  # Import your package.nix
  railsy = import ./packages/railsy/package.nix {
    inherit (pkgs) lib rustPlatform pkg-config openssl fetchFromGitHub;
  };
  salah = import ./packages/salah/package.nix {
    inherit (pkgs) lib stdenv fetchFromGitHub;
  };
in
{
environment.systemPackages = with pkgs; [
      salah
      railsy
      pulseaudio
      vim
      spotify-player
      # Rust
      lldb
      rustc
      rustfmt
      rust-analyzer
      cargo
      du-dust
      libgcc
      # lua
      lua
      lua-language-server
      # performance
      btop
      htop
      hotspot
      linuxPackages_latest.perf
      # Python
      python312
      pylyzer
      python312Packages.pyenchant
      python312Packages.numpy
      python312Packages.matplotlib
      # elixr
      # lexical
      # elixir_1_15
      # cpp
      clang
      clang-tools
      # haskell
      haskellPackages.haskell-language-server
      ghc
      # prog general
      popsicle

      nix-prefetch-github
      ffmpeg
      ollama
      fish
      calibre
      ripgrep
      direnv
      qemu
      tree # directory tree listing
      racket
      zip
      kitty
      lazygit
      lazydocker
      blesh
      atuin
      oh-my-posh
      zsh-powerlevel10k
      docker
      atuin
      scc
      eza
      bat
      speedtest-go
      # imagemagick_light
      gh
      gh-dash
      vscode
      neovim
      # distrobox
      # formatting
      ntfs3g
      dosfstools
      gparted
      # gaming
      # minecraft
      lunar-client
      steam
      # office
      localsend
      obs-studio
      pcmanfm
      # celeste
      # apostrophe
      libsForQt5.dolphin
      nautilus
      alpaca
      impression
      polkit_gnome # auth agent
      xournalpp
      kanata
      obsidian
      zotero
      sublime
      # KCalc
      speedcrunch
      ranger
      xfce.thunar
      clipman
      clippy
      wl-clipboard
      brightnessctl
      prusa-slicer
      gimp
      vlc
      mpv
      # socials
      yt-dlp
      # other/misc
      unzip
      file # how is this not default?
      autojump
      fastfetch
      qbittorrent
      inetutils # ftp ping, whois and such
      cmatrix
      fzf
      atuin
      zsh
      git
      microsoft-edge
      spotify
      discord
      slack
      wget
      feh
      tmux
      # hunspell
      # hunspellDicts.uk_UA
      # hunspellDicts.th_TH
      # gnome
      gnomeExtensions.appindicator
      # Messing around
      wiki-tui
  ];
}
