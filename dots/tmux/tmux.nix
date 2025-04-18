{pkgs}: {
  enable = true;
  # prefix = "C-f";
  plugins = with pkgs.tmuxPlugins; [
    vim-tmux-navigator
    {
      plugin = resurrect;
      extraConfig = "set -g @resurrect-strategy-nvim 'session'";
    }
  ];
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

    # Set status bar colors
    set -g status-bg blue
    set -g status-fg black

    # Nvim status bar combination
    set -g focus-events on
    set -g status-style bg=default
    set -g status-left-length 90
    set -g status-right-length 90
    set -g status-justify centre

    # Reduce escape time for faster response
    set -s escape-time 0

    # Key mappings for pane splitting and navigation
    bind-key -n C-] split-window -h      # Ctrl + 5 to split pane horizontally
    bind-key -n C-'\' split-window -v    # Ctrl + \ to split pane vertically

    # Navigation between panes using vim-like keys (hjkl)
    bind-key h select-pane -L            # h to move left
    bind-key j select-pane -D            # j to move down
    bind-key k select-pane -U            # k to move up
    bind-key l select-pane -R            # l to move right

    # Key mappings for window navigation
    bind-key -n C-n next-window          # Ctrl + n for next window
    bind-key -n C-p previous-window      # Ctrl + p for previous window

    # Bind Alt + [1-9] to switch to windows 1-9
    bind-key -n M-1 select-window -t 1
    bind-key -n M-2 select-window -t 2
    bind-key -n M-3 select-window -t 3
    bind-key -n M-4 select-window -t 4
    bind-key -n M-5 select-window -t 5
    bind-key -n M-6 select-window -t 6
    bind-key -n M-7 select-window -t 7
    bind-key -n M-8 select-window -t 8
    bind-key -n M-9 select-window -t 9

    set -ga terminal-overrides ',*:Ss=\E[%p1%d q:Se=\E[2 q'

    # TODO: Add ctrl + [ for copy paste mode
  '';
}
