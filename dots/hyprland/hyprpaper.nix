{
  monitorName ? "",
}:

{
  enable = true;
  settings = {
    preload = [ "/etc/nixos/misc/Shuttle.JPG" ];
    wallpaper = [
      "${monitorName},/etc/nixos/misc/Shuttle.JPG"
    ];
  };
}
