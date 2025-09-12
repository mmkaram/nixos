{...}: {
  enable = true;
  settings = {
    # Ecosystem
    "ecosystem:no_update_news" = true;

    # Monitor configuration
    monitor = "eDP-1,1920x1080,auto,1";

    # Variables
    "$terminal" = "kitty";
    "$fileManager" = "pcmanfm";
    "$menu" = "rofi -show drun";
    "$mainMod" = "SUPER";

    # Autostart
    exec-once = [
      "nm-applet & flameshot & udiskie"
      "waybar & hyprpaper"
    ];

    # Environment variables
    env = [
      "XCURSOR_SIZE,24"
      "HYPRCURSOR_SIZE,24"
    ];

    # General settings
    general = {
      gaps_in = 3;
      gaps_out = 8;
      border_size = 2;
      "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
      "col.inactive_border" = "rgba(595959aa)";
      resize_on_border = false;
      allow_tearing = false;
      layout = "dwindle";
    };

    # Decoration
    decoration = {
      rounding = 10;
      rounding_power = 0;
      active_opacity = 1.0;
      inactive_opacity = 1.0;
      shadow = {
        enabled = true;
        range = 4;
        render_power = 3;
        color = "rgba(1a1a1aee)";
      };
      blur = {
        enabled = true;
        size = 3;
        passes = 1;
        vibrancy = 0.1696;
      };
    };

    # Animations
    animations = {
      enabled = true;
      bezier = [
        "easeOutQuint,0.23,1,0.32,1"
        "easeInOutCubic,0.65,0.05,0.36,1"
        "linear,0,0,1,1"
        "almostLinear,0.5,0.5,0.75,1.0"
        "quick,0.15,0,0.1,1"
      ];
      animation = [
        "global, 1, 10, default"
        "border, 1, 5.39, easeOutQuint"
        "windows, 1, 4.79, easeOutQuint"
        "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
        "windowsOut, 1, 1.49, linear, popin 87%"
        "fadeIn, 1, 1.73, almostLinear"
        "fadeOut, 1, 1.46, almostLinear"
        "fade, 1, 3.03, quick"
        "layers, 1, 3.81, easeOutQuint"
        "layersIn, 1, 4, easeOutQuint, fade"
        "layersOut, 1, 1.5, linear, fade"
        "fadeLayersIn, 1, 1.79, almostLinear"
        "fadeLayersOut, 1, 1.39, almostLinear"
        "workspaces, 1, 1.94, almostLinear, fade"
        "workspacesIn, 1, 1.21, almostLinear, fade"
        "workspacesOut, 1, 1.94, almostLinear, fade"
      ];
    };

    # Dwindle layout
    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };

    # Master layout
    master = {
      new_status = "master";
    };

    # Misc
    misc = {
      force_default_wallpaper = 0;
      disable_hyprland_logo = true;
    };

    # Input
    input = {
      kb_layout = "us";
      follow_mouse = 1;
      sensitivity = 0;
      touchpad = {
        natural_scroll = true;
      };
    };

    # Gestures
    gestures = {
      workspace_swipe = true;
    };

    # Key bindings
    bind = [
      "$mainMod, Return, exec, kitty tmux"
      "$mainMod SHIFT, Q, killactive"
      "$mainMod, M, exit"
      "$mainMod, A, exec, kitty yazi ."
      "$mainMod SHIFT, A, exec, $fileManager"
      "$mainMod, V, togglefloating"
      "$mainMod, W, togglegroup"
      "$mainMod, bracketright, changegroupactive, f"
      "$mainMod, bracketleft, changegroupactive, b"
      "$mainMod, SPACE, exec, $menu"
      "$mainMod, P, pseudo"
      "$mainMod, E, togglesplit"
      "$mainMod, F, fullscreen, 0"

      # Screenshots
      ", Print, exec, flameshot gui"

      # Media controls
      "ALT, Down, exec, playerctl play-pause"
      ", XF86AudioPlay, exec, playerctl play-pause"
      "ALT, Page_Down, exec, playerctl next"
      "ALT, Page_Up, exec, playerctl previous"

      # Clipboard and utilities
      "Ctrl+Alt, v, exec, sh -c \"cliphist list | rofi -dmenu | cliphist decode | wl-copy\""
      ", Alt+Tab, exec, rofi -show window"
      "Super, semicolon, exec, rofimoji"

      # Focus movement
      "$mainMod, left, movefocus, l"
      "$mainMod, right, movefocus, r"
      "$mainMod, up, movefocus, u"
      "$mainMod, down, movefocus, d"
      "$mainMod, H, movefocus, l"
      "$mainMod, L, movefocus, r"
      "$mainMod, K, movefocus, u"
      "$mainMod, J, movefocus, d"

      # Workspaces
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"
      "$mainMod, 0, workspace, 10"

      # Move to workspace
      "$mainMod SHIFT, 1, movetoworkspace, 1"
      "$mainMod SHIFT, 2, movetoworkspace, 2"
      "$mainMod SHIFT, 3, movetoworkspace, 3"
      "$mainMod SHIFT, 4, movetoworkspace, 4"
      "$mainMod SHIFT, 5, movetoworkspace, 5"
      "$mainMod SHIFT, 6, movetoworkspace, 6"
      "$mainMod SHIFT, 7, movetoworkspace, 7"
      "$mainMod SHIFT, 8, movetoworkspace, 8"
      "$mainMod SHIFT, 9, movetoworkspace, 9"
      "$mainMod SHIFT, 0, movetoworkspace, 10"

      # Special workspace
      "$mainMod, minus, togglespecialworkspace, magic"
      "$mainMod SHIFT, minus, movetoworkspace, special:magic"

      # Mouse workspace switching
      "$mainMod, mouse_down, workspace, e+1"
      "$mainMod, mouse_up, workspace, e-1"
    ];

    # Repeat binds for volume/brightness
    bindel = [
      ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
      ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
    ];

    # Locked binds for media
    bindl = [
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPause, exec, playerctl play-pause"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
    ];

    # Mouse binds
    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];

    # Window rules
    windowrule = [
      "suppressevent maximize, class:.*"
      "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
    ];
  };
}
