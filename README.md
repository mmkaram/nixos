# mmkaram's NixOS Configuration
> Flake powered, home-manager orchestrated, modular, reproducible OS configuration.

Ground up [nixos](https://www.nixos.org) configuration. Includes a lot of neovim, sway, and fish setup.

<!-- TOC -->

- [Home Manager](#Home-Manager)
- [Nvim](#Nvim)
- [Packages](#Packages)
- [Abbreviations](#Abbreviations)
- [TODOs](#TODOs)

<!-- /TOC -->

## Home-Manager

Declared in the [configuration.nix](configuration.nix) file under "init". Contains program specific configs. The docs I use to find options for HM are [here](https://home-manager-options.extranix.com).

## Nvim

Plugins are declared in the [home.nix](home.nix) file under programs.neovim. All lua configs are under the nvim/ directory

## Packages

There are some programs I've packaged but have not had the time to possibly request adding them to nixpkgs. You can find them in the packages/ directory. To import them I import them in my [programs.nix](programs.nix) file which hosts the `enviorment.systemPackages` for my configuration.

## Abbreviations
- nix-rebuild (nix rebuild + home manager + flake default)
- nix-update (update nixpkgs pin to most recent commit, does not rebuild)
- nix-delete (`sudo nix-collect-garbage --delete-old`)

## TODOs
- Yubikey integration for login, sudo, and ssh. Useful wiki page [here](https://wiki.nixos.org/wiki/Yubikey), useful youtube video [here](https://www.youtube.com/watch?v=3CeXbONjIgE&t=329s&pp=ygUNbml4b3MgeXViaWtleQ%3D%3D). Should probably [buy the Yubikey](https://www.yubico.com/eg/product/yubikey-5-nano/) first.
- Secrets manager
- Cloud synced atuin
- Stylix
