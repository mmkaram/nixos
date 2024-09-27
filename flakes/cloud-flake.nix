{
  description = "A NixOS cloud-init base image";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    inherit (pkgs) lib;
  in {
    # Define NixOS configuration outputs
    nixosConfigurations = {
      nixos-cloudinit = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          {
            imports = [
              "${nixpkgs}/nixos/modules/profiles/qemu-guest.nix"
            ];

            networking = {
              hostName = "nixos-cloudinit";
            };

            fileSystems."/" = {
              label = "nixos";
              fsType = "ext4";
              autoResize = true;
            };
            boot.loader.grub.device = "/dev/sda";

            services.openssh.enable = true;
            services.qemuGuest.enable = true;

            security.sudo.wheelNeedsPassword = false;

            users.users.ops = {
              isNormalUser = true;
              extraGroups = [ "wheel" ];
            };

            networking = {
              defaultGateway = { address = "10.1.1.1"; interface = "eth0"; };
              dhcpcd.enable = false;
              interfaces.eth0.useDHCP = false;
            };

            systemd.network.enable = true;

            services.cloud-init = {
              enable = true;
              network.enable = true;
              config = ''
                system_info:
                  distro: nixos
                  network:
                    renderers: [ 'networkd' ]
                  default_user:
                    name: ops

                users:
                  - default

                ssh_pwauth: false

                chpasswd:
                  expire: false

                cloud_init_modules:
                  - migrator
                  - seed_random
                  - growpart
                  - resizefs
                cloud_config_modules:
                  - disk_setup
                  - mounts
                  - set-passwords
                  - ssh
                cloud_final_modules: []
                '';
            };
          }
        ];
      };
    };

    # Build a cloud-init disk image (QCOW2 format)
    packages = {
      image = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          {
            imports = [
              "${nixpkgs}/nixos/modules/profiles/qemu-guest.nix"
            ];

            services.openssh.enable = true;
            services.cloud-init.enable = true;
          }
        ];
      };

      image.qcow2 = import "${nixpkgs}/nixos/lib/make-disk-image.nix" {
        inherit pkgs lib;
        config = image.config;
        name = "nixos-cloudinit";
        format = "qcow2-compressed";
        copyChannel = false;
      };
    };
  };
}

