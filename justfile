
default:
	@just --list

rebuild-pre:
	git add *.nix

rebuild:
	just rebuild-pre
	just/rebuild-flake.sh

update:
	just/update-flake.sh

delete:
	just/delete-old-flake.sh
