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

Plugins are declared in the extended module of my [home.nix](home.nix) called [nvim.nix](nvim/nvim.nix). All lua configs are under the nvim/ directory.
Useful lua pages
- [format.lua](nvim/format.lua) for code formatting
- [lsp.lua](nvim/lsp.lua) to manage lsps

## Packages

There are some programs I've packaged but have not had the time to possibly request adding them to nixpkgs. You can find them in the packages/ directory. To import them I import them in my [programs.nix](programs.nix) file which hosts the `enviorment.systemPackages` for my configuration.

## Abbreviations
- dune-rebuild (nix rebuild + home manager + flake default (roci))
- dune-update (update nixpkgs pin to most recent commit, does not rebuild)
- dune-delete (`sudo nix-collect-garbage --delete-old`)

## TODOs
- check if lldb works now
- vimTex
- nvim debugger
- nvim tmux integration (pane switching)
- make a package for [posting](https://github.com/darrenburns/posting)
- Make nvim shortcuts for sessions
- find out if kitty has built in pane support
- Create a system to easily import dev flakes I use often
- Get the file explorer in nvim to show hidden files (preferably make it a shortcut to toggle)
- Yubikey integration for login, sudo, and ssh. Useful wiki page [here](https://wiki.nixos.org/wiki/Yubikey), useful youtube video [here](https://www.youtube.com/watch?v=3CeXbONjIgE&t=329s&pp=ygUNbml4b3MgeXViaWtleQ%3D%3D). Should probably [buy the Yubikey](https://www.yubico.com/eg/product/yubikey-5-nano/) first.
- Secrets manager
- Cloud synced atuin
- Stylix
- More keyboard remapping
- Obsidian is still kinda borked with nvim
- Get railsy to work
