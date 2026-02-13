{
  pkgs,
  inputs,
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

  # Fingerprint
  services.fprintd = import ../../../dots/fprintd/fprintd.nix pkgs;

  services.power-profiles-daemon.enable = true;

  # Network
  networking.hostName = "Rocinante";
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  # Network proxy Confugration
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Brother drivers
  services.printing.drivers = with pkgs; [
    # gutenprint # Common printer drivers
    # brlaser # Brother-specific drivers
    # brgenml1cupswrapper # Additional Brother drivers
    cups-brother-dcpt310
  ];
  hardware.sane = {
    enable = true;
    extraBackends = with pkgs; [
      sane-airscan # works if the scanner is on the network
    ];
  };
}
