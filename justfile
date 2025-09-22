
default:
	@just --list

rebuild-pre:
	git add *.nix

rebuild:
	just rebuild-pre
	scripts/rebuild-flake.sh

update:
	scripts/update-flake.sh

delete:
	scripts/delete-old-flake.sh

history:
	sudo nixos-rebuild list-generations

update-sk:
	scripts/update-sk.sh
