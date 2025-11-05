{
  isDesktop ? false,
  ...
}:
let
  timeMultiplier = 1.0; # set to 0.1 for testing
in
{
  enable = true;
  settings = {
    general = {
      lock_cmd = "pidof hyprlock || hyprlock";
      before_sleep_cmd = "loginctl lock-session";
      after_sleep_cmd = "hyprctl dispatch dpms on";
      ignore_dbus_inhibit = false;
    };

    listener = [
      {
        timeout = builtins.floor (120 * timeMultiplier); # 2 min - lock
        on-timeout = "loginctl lock-session";
      }
      {
        timeout = builtins.floor (180 * timeMultiplier); # 3 min - screen off
        on-timeout = "hyprctl dispatch dpms off";
        on-resume = "hyprctl dispatch dpms on";
      }
    ]
    ++ (
      if !isDesktop then
        [
          {
            timeout = builtins.floor (240 * timeMultiplier); # 4 min - suspend
            on-timeout = "systemctl suspend";
          }
        ]
      else
        [ ]
    );

    # ++ (
    #   if !isDesktop then
    #     [
    #       {
    #         timeout = builtins.floor (300 * timeMultiplier); # 5 min - hibernate
    #         on-timeout = "systemctl hibernate";
    #       }
    #     ]
    #   else
    #     [ ]
    # );
  };
}
