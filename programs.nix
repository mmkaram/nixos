{pkgs, ... }:
# List packages installed in system profile. To search, run:
# $ nix search wget
{
environment.systemPackages = with pkgs; [
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
      clang
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
      ffmpeg
      # prog general
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
      xournalpp
      kanata
      obsidian
      zotero
      ranger
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
