# mmkaram's NixOS Configuration
> Flake powered, home-manager orchestrated, modular, reproducible OS configuration.

Ground up [nixos](https://www.nixos.org) configuration. Includes a lot of neovim, sway, and fish setup.

<!-- TOC -->

- [Home Manager](#Home-Manager)
- [Nvim](#Nvim)
- [Packages](#Packages)
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

## TODOs
### Updates
- [ ] update @prisma/language-server when fixed, currently broken on nixpkgs
- [ ] Add hurl when not borked
### QoL
- [ ] Cloud synced atuin
- [ ] Add declarative configuration for home EPSON printer
- [ ] Get yubico authenticator app to open on startup and hide window
### Projects
- [ ] Nix flatpak
- [ ] Yubikey for agenix
- [ ] Yubikey for luks
- [ ] Stylix
### Other
- [ ] Track my nmconnection file for school wifi: /etc/NetworkManager/system-connections/waterloo-eduroam.nmconnection (look into ensureProfiles options)
- [ ] Fix single window screensharing on discord and obs, worked fine on gnome
