# mmkaram's NixOS Configuration
> Flake powered, home-manager orchestrated, modular, reproducible OS configuration.

Ground up [nixos](https://www.nixos.org) configuration. Includes a lot of neovim, sway, and fish configuration.

<!-- TOC -->

<!-- - [Home Manager](#Home-Manager) -->
<!-- - [Nvim](#Nvim) -->
<!-- - [Abbreviations](#Abbreviations) -->

<!-- /TOC -->

## Home-Manager

Declared in the [configuration.nix](configuration.nix) file under "init". Contains program specific configs. Docs references are [here](https://home-manager-options.extranix.com).

## Nvim

Plugins are declared in the [home.nix](home.nix) file under programs.neovim. All lua configs are under the nvim/ directory

## Packages

There are some programs I've packaged but have not had the time to possibly request adding them to nixpkgs. You can find them in the packages/ directory. To import them I import them in my [programs.nix](programs.nix) file which hosts the `enviorment.systemPackages` for my configuration.

## Abbreviations
- nix-rebuild (nix rebuild + home manager + flake default)
- nix-update (update nixpkgs pin to most recent commit, does not rebuild)
- nix-delete (`sudo nix-collect-garbage --delete-old`)

