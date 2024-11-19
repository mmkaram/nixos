{ config, lib, pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    settings = [{
      layer = "top";
      position = "top";
      height = 20;
      modules-left = ["sway/workspaces" "sway/mode"];
      # modules-center = ["sway/window"];
      modules-right = [
        "tray"
        "network"
        "cpu"
        "memory"
        "disk"
        "battery"
        "clock"
      ];

      "sway/workspaces" = {
        disable-scroll = true;
        all-outputs = true;
      };

      "network" = {
        format-wifi = "WiFi: {essid} ({signalStrength}%)";
        format-ethernet = "Eth: {ipaddr}/{cidr}";
        format-disconnected = "Disconnected";
        tooltip-format = "{ifname}: {ipaddr}";
      };

      "cpu" = {
        format = "CPU: {usage}%";
        tooltip = false;
      };

      "memory" = {
        format = "RAM: {percentage}%";
        tooltip-format = "Used: {used:0.1f}GiB\nAvailable: {avail:0.1f}GiB";
      };

      "disk" = {
        interval = 30;
        format = "Disk: {percentage_used}%";
        path = "/";
      };

      "battery" = {
        format = "BAT: {capacity}%";
        format-charging = "BAT: {capacity}% 󰂄";
        format-plugged = "BAT: {capacity}% ";
        states = {
          warning = 30;
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
    }];

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

      #workspaces button.focused {
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
