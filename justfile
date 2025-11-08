
default:
	@just --list

rebuild-pre:
	git add *.nix

rebuild num_cores="all":
	@echo "Rebuild with cores: {{num_cores}}"
	just rebuild-pre
	scripts/rebuild-flake.sh {{num_cores}}

update:
	scripts/update-flake.sh

delete:
	scripts/delete-old-flake.sh

history:
	sudo nixos-rebuild list-generations

add-sk-ssh:
	scripts/add-sk-ssh.sh

add-sk-pamu2f:
	scripts/add-sk-pamu2f.sh
