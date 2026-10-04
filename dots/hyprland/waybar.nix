{ ... }:
{
  enable = true;
  settings = [
    {
      layer = "top";
      position = "top";
      height = 22;
      margin-top = 4;
      margin-left = 10;
      margin-right = 10;
      modules-left = [
        "hyprland/workspaces"
        "hyprland/mode"
        "tray"
      ];
      # modules-center = ["hyprland/window"];
      modules-right = [
        "custom/media"
        "pulseaudio"
        "network"
        # "cpu"
        # "memory"
        # "disk"
        "battery"
        "custom/powerprofile"
        "clock"
      ];

      "custom/powerprofile" = {
        exec = "powerprofilesctl get";
        interval = 5;
        format = "PWR: {}";
        tooltip = true;
        on-click = ''
          sh -lc '
            p="$(powerprofilesctl get)"
            case "$p" in
              power-saver) powerprofilesctl set balanced ;;
              balanced) powerprofilesctl set performance ;;
              performance) powerprofilesctl set power-saver ;;
              *) powerprofilesctl set balanced ;;
            esac
          '
        '';
      };

      "hyprland/workspaces" = {
        disable-scroll = true;
        all-outputs = true;
      };

      "pulseaudio" = {
        format = "VOL: {volume}%";
        format-muted = "VOL: Muted";
        on-click = "pavucontrol";
      };

      "custom/media" = {
        exec = "playerctl metadata --format '{{ artist }} - {{ title }} | {{ playerName }} - {{ status }}' --follow";
        format = "{}";
        on-click = "playerctl play-pause";
      };

      "network" = {
        format-wifi = "WiFi: {essid} ({signalStrength}%)";
        format-ethernet = "Eth: {ipaddr}/{cidr}";
        format-disconnected = "Disconnected";
        tooltip-format = "{ifname}: {ipaddr}";
      };

      # "cpu" = {
      #   format = "CPU: {usage}%";
      #   tooltip = false;
      #   interval = 8;
      # };

      "memory" = {
        format = "RAM: {percentage}%";
        tooltip-format = "Used: {used:0.1f}GiB\nAvailable: {avail:0.1f}GiB";
        interval = 60;
      };

      "disk" = {
        interval = 60;
        format = "Disk: {percentage_used}%";
        path = "/";
      };

      "battery" = {
        format = "BAT: {capacity}%";
        format-charging = "BAT: {capacity}% 󰂄";
        format-plugged = "BAT: {capacity}% ";
        states = {
          warning = 20;
          critical = 15;
        };
      };

      "clock" = {
        format = "{:%Y-%m-%d %I:%M %p}";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      };

      "tray" = {
        spacing = 4;
      };
    }
  ];

  # TODO: Clean up
  style = ''
    * {
      border: none;
      font-family: "Roboto Mono", "Font Awesome 5 Free";
      font-size: 11px;
      min-height: 0;
      padding: 0;
      margin: 0;
    }

    window#waybar {
      background: rgba(24, 30, 38, 0.72);
      border: 1px solid rgba(120, 160, 190, 0.22);
      border-radius: 8px;
      color: #e8edf2;
    }

    window#waybar > box {
      padding: 2px 4px;
    }

    #workspaces,
    #mode,
    #tray,
    #custom-media,
    #pulseaudio,
    #network,
    #battery,
    #custom-powerprofile,
    #clock {
      background: rgba(20, 24, 30, 0.62);
      border-radius: 4px;
      margin: 0 1px;
      padding: 0 7px;
      color: #e8edf2;
    }

    #workspaces {
      padding: 0 2px;
    }

    #workspaces button {
      min-width: 19px;
      padding: 0 4px;
      background: transparent;
      color: rgba(232, 237, 242, 0.72);
      border-radius: 3px;
    }

    #workspaces button.active {
      background: rgba(115, 158, 190, 0.34);
      color: #ffffff;
    }

    #workspaces button.urgent {
      background: #d45d5d;
      color: #ffffff;
    }

    @keyframes blink {
      to {
        background-color: #e8edf2;
        color: #111318;
      }
    }

    #battery.warning:not(.charging) {
      background: #f53c3c;
      color: white;
      animation-name: blink;
      animation-duration: 0.5s;
      animation-timing-function: linear;
      animation-iteration-count: infinite;
      animation-direction: alternate;
    }

    #tray > .passive {
      -gtk-icon-effect: dim;
    }

    #tray > .needs-attention {
      -gtk-icon-effect: highlight;
      background-color: #eb4d4b;
    }
  '';
}
