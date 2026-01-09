{
  inputs,
  ...
}:
{
  imports = [
    inputs.agenix.homeManagerModules.default
    ../Common/home.nix
  ];

  services.hypridle = import ../../../dots/hyprland/hypridle.nix { };
  programs.git = import ../../../dots/git/git.nix { };
}
