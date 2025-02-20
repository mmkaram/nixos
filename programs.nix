{
  pkgs,
  inputs,
  ...
}: let
  # railsy = import ./packages/railsy/package.nix {
  #   inherit (pkgs) lib rustPlatform pkg-config openssl fetchFromGitHub;
  # };
  salah = import ./packages/salah/package.nix {
    inherit (pkgs) lib stdenv fetchFromGitHub;
  };
  videomass = import ./packages/videomass/package.nix {
    inherit (pkgs) lib stdenv fetchFromGitHub python312Packages pkgs;
  };
  prisma-lsp = import ./packages/prisma-lsp/package.nix {
    inherit (pkgs) buildNpmPackage fetchFromGitHub;
  };
in {
  environment.systemPackages = with pkgs; [
    # borked
    # videomass
    # railsy
    # prisma-lsp
    salah
    pulseaudio
    vim
    spotify-player
    ## Rust
    # TODO: borked with current nixpkgs
    # lldb
    rustc
    rustfmt
    rust-analyzer
    cargo
    du-dust
    ## js/ts/jsx/tsx
    tailwindcss-language-server
    nodePackages.tailwindcss
    typescript
    typescript-language-server
    prettierd
    nodePackages_latest."@prisma/language-server"
    # the actual "prisma" package is being instaled via npm
    # v 6.3.x was borked when I tested
    prisma-engines
    ## lua
    lua
    lua-language-server
    stylua
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
    hoppscotch
    wget
    unzip
    file
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
    ghostty
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
    code-cursor
    neovim
    ## formatting
    ntfs3g
    gparted # only opens if run from su root
    duf
    libimobiledevice
    ifuse
    ## gaming
    ## minecraft
    lunar-client
    steam
    ## office
    aerc # switch to port 465 for ssl outgoing
    drawio
    rtorrent
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
    beeper
    discord-canary
    ## other/misc
    jq
    xh
    microsoft-edge
    spotify
    ## rand
    wiki-tui
  ];
}
