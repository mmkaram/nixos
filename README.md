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
### QoL
- [ ] Cloud synced atuin
- [ ] Add declarative configuration for home EPSON printer
- [ ] Replace toggle-term with something more native
### Projects
- [ ] Nix flatpak
- [ ] Yubikey for agenix
- [ ] Yubikey for luks
- [ ] Stylix
### Other
- [ ] look into `'programs.ssh' default values will be removed in the future.`
- [ ] Track my nmconnection file for eduroam: /etc/NetworkManager/system-connections/waterloo-eduroam.nmconnection (look into `ensureProfiles` options)
