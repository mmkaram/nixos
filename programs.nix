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
    wrangler
    nodejs
    tailwindcss-language-server
    nodePackages.tailwindcss
    typescript
    typescript-language-server
    prettierd
    prisma
    # Install through npm per project, broken on nixpkgs
    # nodePackages_latest."@prisma/language-server"
    prisma-engines
    # svelte
    svelte-language-server
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
  embeddedTools = with pkgs; [
    kicad
    arduino-ide
    arduino-language-server
    arduino-cli
    platformio
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
    typst
    typstyle
    tinymist # LSP for typst
    opencode
    just
    hoppscotch # api ednpoint client
    atac # TUI api endpoint client
    serie # git graph
    qbittorrent
    inetutils
    popsicle
    caligula
    ffmpeg
    qemu # Virtualizer
    docker
    git
    inputs.agenix.packages."${system}".default
  ];
  terminalTools = with pkgs; [
    caligula
    charm-freeze
    sshx
    starship
    p7zip
    tmux
    mprocs
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
    zed-editor
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
    tetrio-desktop
    prismlauncher
    steam
  ];
  yubikeyTools = with pkgs; [
    yubikey-manager
    yubikey-personalization
    yubikey-touch-detector
    pam_u2f
    yubioath-flutter
    libu2f-host
  ];
  desktopTools = with pkgs; [
    udiskie
    networkmanagerapplet
    pavucontrol
    dunst
    wl-clipboard
    wpa_supplicant
    fprintd-tod
    speedcrunch
  ];
  officeTools = with pkgs; [
    wdisplays
    xdg-utils
    thunderbird
    # drawio
    rtorrent
    rsync
    calibre
    tealdeer
    localsend
    obs-studio
    audacity
    pcmanfm
    impression
    xournalpp
    obsidian
    apostrophe
    zotero
    sublime
    ranger
    yazi
    brightnessctl
    prusa-slicer
    gimp3
    imagemagick
    switcheroo
    ghostscript
    converseen
    kdePackages.kdenlive
    darktable
    vlc
    mpv
    feh # img viewer
  ];
  communicationTools = with pkgs; [
    yt-dlp
    pipeline
    element-desktop
    slack
    beeper
    discord
  ];
  audioTools = with pkgs; [
    ncspot
    spotify-player
    pulseaudio
    spotify
    tidal-hifi
  ];
  browsingTools = with pkgs; [
    inputs.zen-browser.packages."${system}".default
    bitwarden-desktop
    ungoogled-chromium
    wiki-tui
    wikiman
  ];
in {
  environment.systemPackages =
    rustTools
    ++ webTools
    ++ luaTools
    ++ perfTools
    ++ pythonTools
    ++ CXXTools
    ++ embeddedTools
    ++ haskelTools
    ++ nixTools
    ++ devTools
    ++ terminalTools
    ++ diskTools
    ++ games
    ++ yubikeyTools
    ++ officeTools
    ++ communicationTools
    ++ audioTools
    ++ browsingTools
    ++ desktopTools
    ++ customTools;
}
