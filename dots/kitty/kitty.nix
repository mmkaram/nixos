{ pkgs }:
{
  enable = true;
  shellIntegration.enableZshIntegration = true;
  themeFile = "tokyo_night_night";
  font.package = pkgs.fira-code;
  font.name = "FiraCode";
  keybindings = {
    "f11" = "toggle_fullscreen";
    "ctrl+shift+left" = "previous_window";
    "ctrl+shift+right" = "next_window";
  };
  extraConfig = ''
    cursor_trail 9
  '';
}
