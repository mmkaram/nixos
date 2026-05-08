{ ... }:
{
  services.forgejo = {
    enable = true;

    stateDir = "/srv/forgejo";

    useWizard = true;

    database.type = "sqlite3";

    lfs.enable = false;

    settings = {
      DEFAULT = {
        APP_NAME = "Forgejo"; # or rename to "Forgejo"
      };

      service = {
        DISABLE_REGISTRATION = true;
      };

      server = {
        DOMAIN = "git.mmkaram.dev";
        ROOT_URL = "https://git.mmkaram.dev/";
        HTTP_ADDR = "127.0.0.1";
        HTTP_PORT = 3000;
        PROTOCOL = "http";
        SSH_DOMAIN = "tycho";
        SSH_PORT = 22;
        DISABLE_SSH = false;
        LANDING_PAGE = "explore";
      };

      security = {
        INSTALL_LOCK = true;
      };

      mailer = {
        ENABLED = false;
      };
    };
  };
}
