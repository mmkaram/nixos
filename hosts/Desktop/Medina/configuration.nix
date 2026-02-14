{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    ../Common/configuration.nix
  ];

  # Pass inputs to Home Manager
  home-manager.extraSpecialArgs = { inherit inputs; };
  home-manager.users.dd0k.imports = [ ./home.nix ];

  environment.systemPackages = with pkgs; [
    davinci-resolve
  ];

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  networking.hostName = "Medina";
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  # Network proxy Confugration
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # age secrets manager
  # age = import ../../../secrets/age.nix;
}
