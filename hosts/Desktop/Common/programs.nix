{
  pkgs,
  inputs,
  ...
}:
let
  rustTools = with pkgs; [
    lldb
    rustc
    rustfmt
    rust-analyzer
    cargo
    dust
  ];
  webTools = with pkgs; [
    wrangler
    nodejs
    tailwindcss-language-server
    tailwindcss
    typescript
    typescript-language-server
    prettierd
    prisma
    prisma-language-server
    prisma-engines
    svelte-language-server
    bun
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
    perf
  ];
  pythonTools = with pkgs; [
    python312
    python312Packages.pyenchant
    python312Packages.numpy
    python312Packages.matplotlib
    pyright
    uv
    black
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
  ns = pkgs.writeShellScriptBin "ns" (builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh");
  nixTools = with pkgs; [
    nix-search-tv
    ns
    nix-prefetch-github
    nil
    nixfmt
  ];
  devTools = with pkgs; [
    typst
    typstyle
    tinymist # LSP for typst
    opencode
    just
    yaak # api ednpoint client
    atac # TUI api endpoint client
    serie # git graph
    qbittorrent
    inetutils
    caligula
    ffmpeg
    qemu # Virtualizer
    docker
    git
    jujutsu
    jjui
    inputs.agenix.packages."${pkgs.stdenv.hostPlatform.system}".default
  ];
  terminalTools = with pkgs; [
    oh-my-fish
    nitch
    caligula
    charm-freeze # code screenshot
    presenterm
    sshx
    starship
    p7zip
    tmux
    mprocs
    zoxide
    ripgrep
    fd
    tree
    kitty
    lazygit
    lazydocker
    fish
    atuin
    scc # LoC counter
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
    hurl
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
    simple-scan
    waybar
    hyprpaper
    hyprcursor
    rofi
    rofimoji
    rofi-power-menu
    graphite-cursors
    flameshot
    cliphist
    dmenu
    libappindicator-gtk3
    playerctl
    udiskie
    networkmanagerapplet
    pavucontrol
    dunst
    wl-clipboard
    wpa_supplicant_gui
    fprintd-tod
    speedcrunch
  ];
  officeTools = with pkgs; [
    wdisplays
    xdg-utils
    thunderbird
    drawio
    rtorrent
    rsync
    calibre
    localsend
    obs-studio
    audacity
    pcmanfm
    xournalpp
    obsidian
    gnucash
    apostrophe
    zotero
    yazi
    brightnessctl
    prusa-slicer
    gimp3
    imagemagick
    switcheroo
    ghostscript
    converseen
    # kdePackages.kdenlive
    darktable
    rapidraw
    vlc
    mpv
    feh
  ];
  communicationTools = with pkgs; [
    yt-dlp
    pipeline
    element-desktop
    discord
  ];
  audioTools = with pkgs; [
    pulseaudio
    feishin
  ];
  browsingTools = with pkgs; [
    inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
    bitwarden-desktop
    ungoogled-chromium
  ];
in
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
