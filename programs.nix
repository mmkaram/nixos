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
    inputs.zen-browser.packages."${system}".default
    # borked
    # videomass
    # railsy
    salah
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
    uv
    ## elixr
    # lexical
    # elixir_1_15
    ## cpp
    clang
    clang-tools
    ## haskell
    haskellPackages.haskell-language-server
    ghc
    ## racket
    racket
    ## prog general
    hoppscotch # api ednpoint client
    atac # terminal api endpoint client
    serie # git graph
    wget
    unzip
    file
    fastfetch
    pfetch
    qbittorrent
    inetutils
    cmatrix
    feh # img viewer
    tmux
    popsicle
    nix-prefetch-github
    alejandra
    ffmpeg
    qemu # Virtualizer
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
    scc # lines of code counter
    eza
    bat
    speedtest-go
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
    charm-freeze
    fprintd-tod
    wpa_supplicant
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
    cinny-desktop
    iamb
    slack
    # discord
    beeper
    discord-canary
    ## other/misc
    jq # json parser
    xh # curl
    microsoft-edge
    spotify
    ## rand
    wiki-tui
  ];
}
