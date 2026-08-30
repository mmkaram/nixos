{ inputs, ... }:

{
  imports = [
    inputs.comfyui-nix.nixosModules.default
  ];

  nixpkgs.overlays = [
    inputs.comfyui-nix.overlays.default
  ];

  nix.settings = {
    extra-substituters = [
      "https://comfyui.cachix.org"
      "https://nix-community.cachix.org"
      "https://cuda-maintainers.cachix.org"
    ];
    extra-trusted-public-keys = [
      "comfyui.cachix.org-1:33mf9VzoIjzVbp0zwj+fT51HG0y31ZTK3nzYZAX0rec="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
    ];
  };

  services.comfyui = {
    enable = true;
    gpuSupport = "cuda";
    enableManager = true;
    bundledCustomNodes = false;

    listenAddress = "127.0.0.1";
    port = 8188;
    dataDir = "/var/lib/comfyui";
    openFirewall = false;
  };
}
