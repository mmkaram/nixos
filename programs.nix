{pkgs, ...}: let
  railsy = import ./packages/railsy/package.nix {
    inherit (pkgs) lib rustPlatform pkg-config openssl fetchFromGitHub;
  };
  salah = import ./packages/salah/package.nix {
    inherit (pkgs) lib stdenv fetchFromGitHub;
  };
  videomass = import ./packages/videomass/package.nix {
    inherit (pkgs) lib stdenv fetchFromGitHub python312Packages pkgs;
  };
in {
  environment.systemPackages = with pkgs; [
    # borked
    # videomass
    salah
    railsy
    pulseaudio
    vim
    spotify-player
    ## Rust
    lldb
    rustc
    rustfmt
    rust-analyzer
    cargo
    du-dust
    ## lua
    lua
    lua-language-server
    ## performance
    btop
    htop
    hotspot
    linuxPackages_latest.perf
    ## Python
    python312
    python312Packages.pyenchant
    python312Packages.numpy
    python312Packages.matplotlib
    pyright
    ## elixr
    # lexical
    # elixir_1_15
    ## cpp
    clang
    clang-tools
    ## haskell
    haskellPackages.haskell-language-server
    ghc
    ## prog general
    wget
    unzip
    file
    autojump
    fastfetch
    qbittorrent
    inetutils
    cmatrix
    feh
    tmux
    racket
    popsicle
    nix-prefetch-github
    alejandra
    ffmpeg
    direnv
    qemu
    zip
    docker
    fzf
    zsh
    git
    ## Terminal
    zoxide
    ripgrep
    tree
    kitty
    lazygit
    lazydocker
    fish
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
    ## formatting
    ntfs3g
    gparted # only opens if run from su root
    libimobiledevice
    ifuse
    ## gaming
    ## minecraft
    lunar-client
    steam
    ## office
    aerc # switch to port 465 for ssl outgoing
    rsync
    dunst
    wl-clipboard
    calibre
    tealdeer
    localsend
    obs-studio
    pcmanfm
    impression
    polkit_gnome # auth agent
    xournalpp
    kanata
    obsidian
    zotero
    sublime
    speedcrunch
    ranger
    brightnessctl
    prusa-slicer
    gimp
    vlc
    mpv
    ## socials
    yt-dlp
    element-desktop
    iamb
    slack
    # discord
    discord-canary
    ## other/misc
    microsoft-edge
    spotify
    ## rand
    wiki-tui
  ];
}
