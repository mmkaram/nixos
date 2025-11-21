{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.agenix.homeManagerModules.default
    ../Common/home.nix
  ];
  services.hypridle = import ../../dots/hyprland/hypridle.nix {
    lock-time = 10 * 60;
    screen-time = 15 * 60;
    suspend-time = 0;
    hibernate-time = 0;
  };
  programs.git = import ../../dots/git/git.nix { gpgSign = false; };
}
