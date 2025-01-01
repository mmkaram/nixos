{
  enable = true;
  shellAliases = {
    gc = "git commit -a -m";
    gP = "git push";
    gp = "git pull";
    ga = "git add .";
    gitgraph = "git log --online --graph --decorate -all";
    lgit = "lazygit";
    ghd = "gh-dash";
    ldoc = "lazydocker";
    t = "tmux";
    icat = "kitten icat";
    cdb = "cd ..";

    copy = "wl-copy";
    wifi = "nmtui";
    dune-rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#roci";
    dune-update = "cd /etc/nixos && sudo nix flake update";
    dune-delete-older-than = "sudo nix-collect-garbage --delete-older-than ";
    dune-delete = "sudo nix-collect-garbage --delete-old";

    up = "ping 8.8.8.8";
    space = "du -h -s";
    cls = "clear";
    r = "ranger";
    py = "python3";
    l = "eza -lh";
    el = "eza --git-repos -h -l -all";
    sp = "spotify_player";
    ff = "fastfetch";
    n = "nvim";
    sn = "sudo nvim";
    map = "telnet mapscii.me";
    dsize = "du -sh";

    hibernate = "systemctl hibernate";
  };
  shellInit = ''
    fish_vi_key_bindings
    # fish_default_key_bindings
    set -U fish_greeting
    set PROG "/home/dd0k/prog"
    set NIX "/etc/nixos"
    direnv hook fish | source
  '';
}
