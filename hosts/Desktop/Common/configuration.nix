{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ../../Common/configuration.nix
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
  # Enable wayland on electron applications
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Programs
  environment.systemPackages = import ../Common/programs.nix { inherit pkgs inputs; };

  # Brightness and volume
  programs.light.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  # printing gui
  programs.system-config-printer.enable = true;
  # Avahi for mDNS
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # services
  # ios usb tethering
  services.usbmuxd.enable = true;

  # Virtualization
  services.qemuGuest.enable = true;
  programs.virt-manager.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
    };
  };

  # Enable localsend
  programs.localsend.enable = true;
  programs.localsend.openFirewall = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };

  # Enable nix-ld
  programs.nix-ld.enable = true;

  # Allow 16MB for max perf locked memory
  boot.kernel.sysctl = {
    "kernel.perf_event_mlock_kb" = 16 * 1024;
  };

  # Enbale auto garbage collection
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}
