{
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../Common/configuration.nix
    # inputs.home-manager.nixosModules.default
  ];

  networking.hostName = "Tycho";
}
