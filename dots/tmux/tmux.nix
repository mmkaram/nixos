{
  enable = true;
  # prefix = "C-f";
  extraConfig = ''
    # Enable mouse support
    setw -g mouse on

    # Use vi key bindings for copy mode
    setw -g mode-keys vi

    # Unbind the default mouse drag behavior
    unbind MouseDragEnd1Pane

    # Set the prefix key to Ctrl + X
    unbind C-b          # Unbind the default prefix (Ctrl + B)
    set -g prefix C-x   # Set new prefix to Ctrl + X
    bind C-x send-prefix # Allow sending prefix key

    # Start window numbering at 1 instead of 0
    set -g base-index 1 # Set base index for windows to 1
    set -g pane-base-index 1 # Set base index for panes to 1

    # Optional: Uncomment to set default command/shell
    # set-option -g default-command "${pkgs.zsh}/bin/zsh"
    # set-option -g default-shell "${pkgs.zsh}/bin/zsh"

    # Set status bar colors
    set -g status-bg blue
    set -g status-fg black

    # Reduce escape time for faster response
    set -s escape-time 0

    # Key mappings for pane splitting and navigation
    bind -n C-% split-window -h   # Ctrl + % to split a pane horizontally
    bind -n C-\ split-window -v    # Ctrl + \ to split a pane vertically

    # Navigation between panes using vim-like keys (hjkl)
    bind -n C-x h select-pane -L   # Ctrl + x then h to move left
    bind -n C-x j select-pane -D   # Ctrl + x then j to move down
    bind -n C-x k select-pane -U   # Ctrl + x then k to move up
    bind -n C-x l select-pane -R   # Ctrl + x then l to move right

    # Key mappings for window navigation
    bind -n C-n next-window         # Ctrl + n for next window
    bind -n C-p previous-window     # Ctrl + p for previous window

  '';
}
