{
  description = "mmkaram's config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
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
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-hardware,
      agenix,
      ...
    }@inputs:
    {
      nixosConfigurations.Rocinante = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./hosts/Desktop/Rocinante/configuration.nix
          agenix.nixosModules.default
          inputs.home-manager.nixosModules.default
          nixos-hardware.nixosModules.framework-amd-ai-300-series
        ];
      };
      nixosConfigurations.Medina = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./hosts/Desktop/Medina/configuration.nix
          agenix.nixosModules.default
          inputs.home-manager.nixosModules.default
        ];
      };
      nixosConfigurations.Tycho = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./hosts/Server/Tycho/configuration.nix
          agenix.nixosModules.default
          inputs.home-manager.nixosModules.default
        ];
      };
    };
}
