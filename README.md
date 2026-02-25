# mmkaram's NixOS Configuration
> Flake powered, home-manager orchestrated, modular, reproducible OS configuration.

Ground up [nixos](https://www.nixos.org) configuration. Includes a lot of neovim, hyprland, and fish setup.

<!-- TOC -->

- [Home Manager](#Home-Manager)
- [Nvim](#Nvim)
- [Packages](#Packages)
- [TODOs](#TODOs)

<!-- /TOC -->

## Home-Manager

Imported in the [configuration.nix](./hosts/Rocinante/configuration.nix) file under "init". Contains program specific configs.

## Nvim

Plugins are declared in the extended module of my [home.nix](home.nix) called [nvim.nix](nvim/nvim.nix). All lua configs are under the nvim/ directory.
Useful lua pages
- [format.lua](./dots/nvim/format.lua) for code formatting
- [lsp.lua](./dots/nvim/lsp.lua) to manage lsps

## TODOs
### nvim
- [ ] Keybind to build/run code (in toggleterm?)
- [ ] See images in obsidian-nvim
- [ ] Equivalent to vscode dev-containers
### QoL
- [ ] Replace toggle-term with something more native
- [ ] Use config.age syntax
### Projects
- [ ] Nix flatpak
- [ ] Yubikey for agenix
- [ ] Yubikey for luks
- [ ] Stylix
### Tycho
- [ ] Linkwarden
- [ ] microbin
- [ ] nextcloud
- [ ] secret last.fm api key
- [ ] run factorio/minecraft server?
- [ ] get neovim config
- [ ] get cloudflared, just, neovim, and other programs
- [ ] auto boot into latest nixos config from grub to save time on boot
