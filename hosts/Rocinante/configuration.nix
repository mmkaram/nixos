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

  # yubikey/yubico
  services.pcscd.enable = true;
  services.udev.packages = [ pkgs.yubikey-personalization ];

  security.pam.u2f = {
    enable = true;
    # control = "required";
    settings = {
      interactive = true;
      cue = true;
      authFile = "/etc/nixos/secrets/u2f_keys";
    };
  };

  security.pam.services = {
    login = {
      u2fAuth = true;
      # unixAuth = false;
    };
    sudo = {
      u2fAuth = true;
      # unixAuth = false;
    };
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    settings = {
      disable-scdaemon = true;
    };
  };
}
