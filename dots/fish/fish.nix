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
    cd = "z";

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
    # Set geminiAPI key as env var
    source /run/agenix/gemini
    fish_vi_key_bindings
    # Disable greeting
    set -U fish_greeting
    # Set env vars
    set PROG "/home/dd0k/prog"
    set NIX "/etc/nixos"
    # Enable direnv in fish
    direnv hook fish | source
    # Set alt+l to clear screen
    bind -e \el
    bind -M insert \el 'clear-screen'
    # Set nvim as manpager
    set -gx MANPAGER 'nvim +Man!'
  '';

  functions = {
    gclone = ''
      function gclone
        if test (count $argv) -eq 1
          set repo $argv[1]
          git clone git@github.com:mmkaram/$repo.git
        else
          echo "Usage: gclone <repository_name>"
        end
      end
    '';
    devshell = ''
      function devshell
        if test (count $argv) -eq 1
          set package $argv[1]
          nix shell github:nixos/nixpkgs/nixos-unstable#$package
        else
          echo "Usage: devshell <package_name>"
        end
      end
    '';
  };
}
