{
  description = "mmkaram's config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    zen-browser.url = "github:mmkaram/zen-browser-flake";
    ghostty.url = "github:mitchellh/ghostty";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ghostty,
    ...
  } @ inputs: {
    nixosConfigurations.roci = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix
        inputs.home-manager.nixosModules.default
      ];
    };
  };
}
