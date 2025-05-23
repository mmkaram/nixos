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
- [format.lua](./nvim/format.lua) for code formatting
- [lsp.lua](./nvim/lsp.lua) to manage lsps

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
- [X] Use virtual lines for error messsages
- [X] Avante.nvim
- [X] Go back to upstream neo-tree-nvim when 2025-03-27/31 is live
- [ ] [Flash.nvim](https://youtu.be/eJ3XV-3uoug?si=UxFJs2Xk0Ve6PXTc)
- [ ] Update octo-nvim when it isn't broken. borked ver: 2025/04/24
- [ ] mini.ai
- [ ] vimTex
- [ ] nvim debugger
- [ ] js/ts lsp diagnostics only show errors/warnings in open files
- [ ] Get the file explorer in nvim to show hidden files (preferably make it a shortcut to toggle)
- [ ] Obsidian is still kinda borked with nvim
### Updates
- [X] update gimp (3.X.X)
- [ ] update @prisma/language-server when fixed, currently broken on nixpkgs
- [ ] update iamb (cur 0.10) to a version that supports images
- [ ] Get the nixpkgs version of the Zen browser when it's up
### QoL
- [ ] all fish functions only work the second time I run them
- [ ] Cloud synced atuin
- [ ] Add declarative configuration for home EPSON printer
### Projects
- [ ] Yubikey for agenix
- [ ] Stylix
### Other
- [ ] Track my nmconnection file for school wifi: /etc/NetworkManager/system-connections/waterloo-eduroam.nmconnection (look into ensureProfiles options)
- [ ] Get railsy to work
- [ ] Preview pdfs in ranger
- [ ] Fix single window screen share, both OBS and discord streaming only allow me to share the whole screen with all windows, may be a sway problem, worked fine on gnome I think
