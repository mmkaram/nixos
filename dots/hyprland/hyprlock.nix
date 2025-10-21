{ }:
{
  enable = true;
  settings = {
    # Desktop background (captured at lock time)
    background = [
      {
        path = "/etc/nixos/misc/Shuttle.JPG";
        blur_passes = 3;
        blur_size = 8;
        brightness = 0.8;
        contrast = 0.9;
        vibrancy = 0.15;
      }
    ];

    # Input field in the center of the screen
    input-field = [
      {
        size = "400, 90";
        outline_thickness = 4;
        inner_color = "rgba(20,20,20,0.7)";
        outer_color = "rgba(255,255,255,0.15)";
        rounding = -1;
        font_color = "rgba(230,230,230,1.0)";
        font_family = "Noto Sans";
        placeholder_text = "<i>Enter password...</i>";
        fade_on_empty = false;
        halign = "center";
        valign = "center";
      }
    ];

    # Time and date labels at top
    label = [
      {
        text = "$TIME12";
        font_size = 40;
        font_family = "Noto Sans";
        color = "rgba(255, 255, 255, 0.9)";
        halign = "center";
        valign = "top";
        position = "0, -30";
      }
      {
        text = "cmd[update:60000] date '+%A, %B %d'";
        font_size = 20;
        font_family = "Noto Sans";
        color = "rgba(220, 220, 220, 0.8)";
        halign = "center";
        valign = "top";
        position = "0, -80";
      }
    ];
  };
}
