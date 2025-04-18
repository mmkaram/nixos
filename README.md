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
### Completed
- [X] nvim tmux integration (pane switching)
- [X] add rofi like app that can filter through open windows
- [X] find out if kitty has built in pane support
- [X] Secrets manager
- [X] Implement nix-ld
- [X] Implement nix-alien
- [X] find a way to insert emojis
### Nvim
- [ ] Update to nvim 0.11.X to use multiline in file error messages
- [ ] Go back to upstream neo-tree-nvim when 2025-03-27/31 is live
- [ ] mini.ai
- [ ] vimTex
- [ ] nvim debugger
- [ ] Avante.nvim
- [ ] js/ts lsp diagnostics only show errors/warnings in open files
- [ ] Get the file explorer in nvim to show hidden files (preferably make it a shortcut to toggle)
- [ ] Obsidian is still kinda borked with nvim
### Updates
- [ ] update iamb (cur 0.10) to a version that supports images
- [ ] update gimp (3.X.X)
- [ ] Get the nixpkgs version of the Zen browser when it's up
### QoL
- [ ] all fish functions only work the second time I run them
- [ ] get rofi file browser to open reasonable defaults for specific filetypes
- [ ] Cloud synced atuin
### Projects
- [ ] Yubikey integration for login, sudo, and ssh. Useful wiki page [here](https://wiki.nixos.org/wiki/Yubikey), useful youtube video [here](https://www.youtube.com/watch?v=3CeXbONjIgE&t=329s&pp=ygUNbml4b3MgeXViaWtleQ%3D%3D). Should probably [buy the Yubikey](https://www.yubico.com/eg/product/yubikey-5-nano/) first.
- [ ] Stylix
### Other
- [ ] Track my nmconnection file for school wifi: /etc/NetworkManager/system-connections/waterloo-eduroam.nmconnection
- [ ] Get railsy to work
- [ ] Preview pdfs in ranger
- [ ] Fix single window screen share, both OBS and discord streaming only allow me to share the whole screen with all windows, may be a sway problem, worked fine on gnome I think
