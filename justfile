
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

update-sk:
	scripts/update-sk.sh

add-sk:
	scripts/add-yubi-auth.sh
