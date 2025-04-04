{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "nvme" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/aec07cd1-7963-4b73-b2d5-25a4a6080bf7";
    fsType = "ext4";
  };

  # Encryption details
  # The first line is for the swap encryption, after running the NixOS Calamares installer this line was put into my ./configuration.nix
  # This is an issue because this is machine specific, hopefully this big has been fixed, if not should probably report.
  boot.initrd.luks.devices."luks-212fbe65-b5e7-4935-b1d0-17a592d6ce54".device = "/dev/disk/by-uuid/212fbe65-b5e7-4935-b1d0-17a592d6ce54";
  # This was put in the correct file, see comment above.
  boot.initrd.luks.devices."luks-ced2ee20-76d9-40a2-8f6c-985c09f1a883".device = "/dev/disk/by-uuid/ced2ee20-76d9-40a2-8f6c-985c09f1a883";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/43E4-F8DD";
    fsType = "vfat";
    options = ["fmask=0077" "dmask=0077"];
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/7a4eb0c0-fafe-4a48-a432-5baf3ec20c7b";}
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s31f6.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;
  # networking.interfaces.wwan0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
