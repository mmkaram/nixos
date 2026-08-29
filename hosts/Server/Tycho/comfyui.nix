{ inputs, ... }:

{
  imports = [
    inputs.comfyui-nix.nixosModules.default
  ];

  nixpkgs.overlays = [
    inputs.comfyui-nix.overlays.default
  ];

  services.comfyui = {
    enable = true;
    gpuSupport = "cuda";
    enableManager = true;

    listenAddress = "127.0.0.1";
    port = 8188;
    dataDir = "/var/lib/comfyui";
    openFirewall = false;
  };
}
