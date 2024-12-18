{pkgs}: {
  # "Mod4+Shift+d" = "exec ${pkgs.dmenu}/bin/dmenu_path | ${pkgs.dmenu}/bin/dmenu | ${pkgs.findutils} bin/xargs swaymsg exec --";
  "Ctrl+Shift+Escape" = "exec 'kitty btop'";
  "Mod4+d" = "exec 'wofi --show drun'";
  "Mod4+Return" = "exec kitty tmux";
  "Mod4+Shift+Return" = "exec kitty";
  "Mod4+a" = "exec pcmanfm";
  "Mod4+Shift+S" = "exec 'systemctl hibernate'";
  "Mod4+Apostrophe" = "exec 'swaylock -c 145874 & systemctl suspend-then-hibernate'";
  "Mod4+Semicolon" = "exec 'swaylock -c 145874'";
  "Mod4+s" = "exec 'kitty ranger'";

  # vol
  "Alt+Shift+Equal" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
  "Alt+Shift+Minus" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
  "XF86AudioMute" = "exec 'pactl set-sink-mute @DEFAULT_SINK@ toggle'";
  "Alt+Down" = "exec 'playerctl play-pause'";
  "XF86AudioPlay" = "exec 'playerctl play-pause'";
  "Alt+Page_Down" = "exec 'playerctl next'";
  "Alt+Page_Up" = "exec 'playerctl previous'";

  # bright
  "XF86MonBrightnessDown" = "exec 'brightnessctl set 5%-'";
  "XF86MonBrightnessUp" = "exec 'brightnessctl set 5%+'";
  "Alt+Shift+9" = "exec 'brightnessctl set 5%-'";
  "Alt+Shift+0" = "exec 'brightnessctl set 5%+'";

  # screen
  "Print" = "exec 'shotman --capture region'";

  # New keybindings
  "Mod4+0" = "workspace number 10";
  "Mod4+1" = "workspace number 1";
  "Mod4+2" = "workspace number 2";
  "Mod4+3" = "workspace number 3";
  "Mod4+4" = "workspace number 4";
  "Mod4+5" = "workspace number 5";
  "Mod4+6" = "workspace number 6";
  "Mod4+7" = "workspace number 7";
  "Mod4+8" = "workspace number 8";
  "Mod4+9" = "workspace number 9";
  "Mod4+Down" = "focus down";
  "Mod4+Left" = "focus left";
  "Mod4+Right" = "focus right";
  "Mod4+Shift+0" = "move container to workspace number 10";
  "Mod4+Shift+1" = "move container to workspace number 1";
  "Mod4+Shift+2" = "move container to workspace number 2";
  "Mod4+Shift+3" = "move container to workspace number 3";
  "Mod4+Shift+4" = "move container to workspace number 4";
  "Mod4+Shift+5" = "move container to workspace number 5";
  "Mod4+Shift+6" = "move container to workspace number 6";
  "Mod4+Shift+7" = "move container to workspace number 7";
  "Mod4+Shift+8" = "move container to workspace number 8";
  "Mod4+Shift+9" = "move container to workspace number 9";
  "Mod4+Shift+Down" = "move down";
  "Mod4+Shift+Left" = "move left";
  "Mod4+Shift+Right" = "move right";
  "Mod4+Shift+Up" = "move up";
  "Mod4+Shift+c" = "reload";
  "Mod4+Shift+e" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";
  "Mod4+Shift+h" = "move left";
  "Mod4+Shift+j" = "move down";
  "Mod4+Shift+k" = "move up";
  "Mod4+Shift+l" = "move right";
  "Mod4+Shift+minus" = "move scratchpad";
  "Mod4+Shift+q" = "kill";
  "Mod4+Shift+space" = "floating toggle";
  "Mod4+Up" = "focus up";
  # "Mod4+a" = "focus parent";
  "Mod4+b" = "splith";
  "Mod4+e" = "layout toggle split";
  "Mod4+f" = "fullscreen toggle";
  "Mod4+h" = "focus left";
  "Mod4+j" = "focus down";
  "Mod4+k" = "focus up";
  "Mod4+l" = "focus right";
  "Mod4+minus" = "scratchpad show";
  "Mod4+r" = "mode resize";
  "Mod4+q" = "layout stacking";
  "Mod4+space" = "focus mode_toggle";
  "Mod4+v" = "splitv";
  "Mod4+w" = "layout tabbed";
  "Mod4+Ctrl+Left" = "workspace prev";
  "Mod4+Ctrl+Right" = "workspace next";
}
