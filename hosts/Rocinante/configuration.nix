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

  # Enable window manager
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };
  services.upower.enable = true;
  services.dbus.enable = true;
  # enable wayland on electron applications
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Fingerprint
  services.fprintd = import ../../dots/fprintd/fprintd.nix pkgs;

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

  # Enable tailscale
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
    openFirewall = true;
    extraUpFlags = [
      "--ssh=true"
    ];
  };
}
