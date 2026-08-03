{ pkgs, ... }:
{
  # TODO: Fix fprint
  enable = false;
  tod.enable = true;
  tod.driver = pkgs.libfprint-2-tod1-goodix;
}
