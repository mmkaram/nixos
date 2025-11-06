{
  lock-time ? 120,
  screen-time ? 180,
  suspend-time ? 240,
  hibernate-time ? 300,
  ...
}:
let
  timeMultiplier = 1.0; # set to 0.1 for testing

  makeListener =
    timeout: attrs:
    if timeout != 0 then
      attrs
      // {
        timeout = builtins.floor (timeout * timeMultiplier);
      }
    else
      null;

  optionalListener = l: if l == null then [ ] else [ l ];
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

    listener =
      # lock
      (optionalListener (
        makeListener lock-time {
          on-timeout = "loginctl lock-session";
        }
      ))
      # screen
      ++ (optionalListener (
        makeListener screen-time {
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ))
      # suspend
      ++ (optionalListener (
        makeListener suspend-time {
          on-timeout = "systemctl suspend";
        }
      ))
      # hibernate
      ++ (optionalListener (
        makeListener hibernate-time {
          on-timeout = "systemctl hibernate";
        }
      ));
  };
}
