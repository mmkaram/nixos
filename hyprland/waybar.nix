{ ... }:
{
  programs.waybar = {
    enable = true;
    settings = [
      {
        layer = "top";
        position = "top";
        height = 20;
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
          "clock"
        ];

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
          format = "{:%Y-%m-%d %H:%M}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        "tray" = {
          spacing = 10;
        };
      }
    ];

    # TODO: Clean up
    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "Roboto Mono", "Font Awesome 5 Free";
        font-size: 11px;
        min-height: 0;
        padding: 0;
        margin: 0;
      }

      window#waybar {
        background: rgba(43, 48, 59, 0.5);
        border-bottom: 3px solid rgba(100, 114, 125, 0.5);
        color: white;
      }

      #workspaces button {
        padding: 0 5px;
        background: transparent;
        color: white;
        border-bottom: 3px solid transparent;
      }

      #workspaces button.active {
          background: #64727D;
          border-bottom: 3px solid white;
      }

      #mode, #clock, #battery, #cpu, #memory, #network, #pulseaudio, #custom-spotify, #tray, #mode, #clock, #batery {
        padding: 0 5px;
        margin: 0 3px;
      }

      #mode {
        background: #64727D;
        border-bottom: 3px solid white;
      }

      @keyframes blink {
        to {
          background-color: #ffffff;
          color: black;
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

      #tray {
        background-color: #2980b9;
      }

      #tray > .passive {
        -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
        background-color: #eb4d4b;
      }
    '';
  };
}
