{
  pkgs,
  inputs,
  ...
}: let
  salah = import ./packages/salah/package.nix {
    inherit (pkgs) lib stdenv fetchFromGitHub;
  };
  customTools = [
    salah
  ];
  rustTools = with pkgs; [
    lldb
    rustc
    rustfmt
    rust-analyzer
    cargo
    du-dust
  ];
  webTools = with pkgs; [
    tailwindcss-language-server
    nodePackages.tailwindcss
    typescript
    typescript-language-server
    prettierd
    prisma
    nodePackages_latest."@prisma/language-server"
    prisma-engines
  ];
  luaTools = with pkgs; [
    lua
    lua-language-server
    stylua
  ];
  perfTools = with pkgs; [
    btop
    htop
    hotspot
    linuxPackages_latest.perf
  ];
  pythonTools = with pkgs; [
    python312
    python312Packages.pyenchant
    python312Packages.numpy
    python312Packages.matplotlib
    pyright
    uv
  ];
  CXXTools = with pkgs; [
    clang
    clang-tools
  ];
  haskelTools = with pkgs; [
    haskellPackages.haskell-language-server
    ghc
  ];
  nixTools = with pkgs; [
    nix-prefetch-github
    alejandra
    nil
  ];
  devTools = with pkgs; [
    hoppscotch # api ednpoint client
    atac # terminal api endpoint client
    serie # git graph
    qbittorrent
    inetutils
    popsicle
    ffmpeg
    qemu # Virtualizer
    docker
    git
    inputs.agenix.packages."${system}".default
  ];
  terminalTools = with pkgs; [
    p7zip
    tmux
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
    vim
    zip
    unzip
    wget
    file
    fastfetch
    pfetch
    jq # json parser
    xh # curl
    fzf
    zsh
  ];
  diskTools = with pkgs; [
    ntfs3g
    gparted # only opens if run from su root
    duf
    libimobiledevice
    ifuse
  ];
  games = with pkgs; [
    lunar-client
    steam
  ];
  desktopTools = with pkgs; [
    dunst
    wl-clipboard
    wpa_supplicant
    fprintd-tod
    speedcrunch
  ];
  officeTools = with pkgs; [
    xdg-utils
    charm-freeze
    aerc # switch to port 465 for ssl outgoing
    drawio
    rtorrent
    rsync
    calibre
    tealdeer
    localsend
    obs-studio
    pcmanfm
    impression
    xournalpp
    obsidian
    zotero
    sublime
    ranger
    brightnessctl
    prusa-slicer
    gimp
    vlc
    mpv
    feh # img viewer
  ];
  communicationTools = with pkgs; [
    yt-dlp
    element-desktop
    cinny-desktop
    iamb
    slack
    beeper
    discord
  ];
  audioTools = with pkgs; [
    spotify-player
    pulseaudio
    spotify
  ];
  browsingTools = with pkgs; [
    inputs.zen-browser.packages."${system}".default
    microsoft-edge
    wiki-tui
  ];
in {
  environment.systemPackages =
    rustTools
    ++ webTools
    ++ luaTools
    ++ perfTools
    ++ pythonTools
    ++ CXXTools
    ++ haskelTools
    ++ nixTools
    ++ devTools
    ++ terminalTools
    ++ diskTools
    ++ games
    ++ officeTools
    ++ communicationTools
    ++ audioTools
    ++ browsingTools
    ++ desktopTools
    ++ customTools;
}
