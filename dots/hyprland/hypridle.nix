{ }:
{
  enable = true;
  settings = {
    general = {
      lock_cmd = "hyprlock";
      after_sleep_cmd = "hyprctl dispatch dpms on";
      ignore_dbus_inhibit = false;
    };

    listener = [
      {
        timeout = 300; # 2 minutes
        on-timeout = "systemctl suspend";
        on-resume = "hyprctl dispatch dpms on";
      }
    ];
  };
}
