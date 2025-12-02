{
  inputs,
  config,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    ../Common/configuration.nix
  ];

  # Enable the COSMIC login manager
  services.displayManager.cosmic-greeter.enable = true;

  # Enable the COSMIC desktop environment
  services.desktopManager.cosmic.enable = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  # hardware.nvidia.open = true;

  hardware.nvidia = {
    open = false; # use proprietary driver (faster)
    modesetting.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  networking.hostName = "MedinaStation";
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  # Network proxy Confugration
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # age secrets manager
  age = import ../../secrets/age.nix;
}
