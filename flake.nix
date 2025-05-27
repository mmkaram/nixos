{
  description = "mmkaram's config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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
    agenix,
    nix-alien,
    ...
  } @ inputs: {
    nixosConfigurations.Rocinante = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
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
