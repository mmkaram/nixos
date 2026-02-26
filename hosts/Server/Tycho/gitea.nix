{ ... }:
{
  services.gitea = {
    enable = true;

    appName = "Gitea";

    settings = {
      service = {
        DISABLE_REGISTRATION = true;
      };
      server = {
        DOMAIN = "git.mmkaram.dev"; # external hostname
        ROOT_URL = "https://git.mmkaram.dev/"; # public URL
        HTTP_ADDR = "127.0.0.1";
        HTTP_PORT = 3000;

        PROTOCOL = "http";
        SSH_DOMAIN = "tycho";
        SSH_PORT = 22; # host sshd
        START_SSH_SERVER = false; # use host OpenSSH, not Gitea’s internal
        LANDING_PAGE = "explore";
      };

      security = {
        INSTALL_LOCK = true; # skip installer once configured
      };

      database = {
        DB_TYPE = "sqlite3";
        # PATH = "gitea.db";
      };

      # Basic email stub
      email = {
        ENABLED = false;
      };
    };

    # Data lives here: repos, config, avatars, etc.
    stateDir = "/var/lib/gitea";
  };

}
