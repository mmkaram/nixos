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
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-old,
      agenix,
      ...
    }@inputs:
    {
      oldPkgs = final: prev: {
        prismaLanguageServer =
          (import nixpkgs-old {
            system = prev.system;
            config.allowUnfree = true;
          }).nodePackages."@prisma/language-server";

        hurl =
          (import nixpkgs-old {
            system = prev.system;
            config.allowUnfree = true;
          }).hurl;
      };

      nixosConfigurations.Rocinante = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = [
          {
            nixpkgs.overlays = [ self.oldPkgs ];
          }
          ./hosts/Rocinante/configuration.nix
          agenix.nixosModules.default
          inputs.home-manager.nixosModules.default
        ];
      };
    };
}
