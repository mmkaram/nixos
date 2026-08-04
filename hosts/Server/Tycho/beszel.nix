{ ... } :
{
	services.beszel.hub = {
		enable = true;
		environment = {
			# DISABLE_PASSWORD_AUTH = "true";
		};
		host = "0.0.0.0";
	};

	services.beszel.agent = {
		enable = true;
		environment = {
			SKIP_SYSTEMD = false;
			KEY = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAvq+q3EJkp92NggXIN9sdkk8nhf2iJIT5MLOY6jqoer";
		};

		smartmon ={
			enable = true;
			deviceAllow = [
			"/dev/sda"
			"/dev/sdb"
			"/dev/sdc"
			];
		};
	};
}

