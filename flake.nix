{
  description = "mmkaram's config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-old.url = "github:nixos/nixpkgs/813d065adb7d28076c1649a9761777dae5e38108";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-old,
    agenix,
    nix-alien,
    ...
  } @ inputs: let
    system = "x86_64-linux";

    pkgsOld = import nixpkgs-old {
      inherit system;
      config = {allowUnfree = true;};
    };
  in {
    nixosConfigurations.Rocinante = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs;
        pkgsOld = pkgsOld;
      };
      modules = [
        ./configuration.nix
        agenix.nixosModules.default
        inputs.home-manager.nixosModules.default
        ({pkgs, ...}: {
          environment.systemPackages = [
            inputs.nix-alien.packages.${pkgs.system}.nix-alien
          ];
          programs.nix-ld.enable = true;
        })
      ];
    };
  };
}
