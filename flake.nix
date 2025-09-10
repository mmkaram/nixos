{
  description = "mmkaram's config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-prisma.url = "github:nixos/nixpkgs/fdd340a071fbb4c10010fb2f8a15467700de2c31";
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
    nixpkgs-prisma,
    agenix,
    nix-alien,
    ...
  } @ inputs: let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config = {allowUnfree = true;};
    };

    pkgsPrisma = import nixpkgs-prisma {
      inherit system;
      config = {allowUnfree = true;};
    };
  in {
    nixosConfigurations.Rocinante = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
        pkgsPrisma = pkgsPrisma;
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
