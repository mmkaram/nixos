{ pkgs, ... }:
{
  services.mediawiki = {
    enable = true;
    name = "Karam Wiki";
    httpd.virtualHost = {
      hostName = "wiki.mmkaram.dev";
      adminAddr = "admin@mmkaram.dev"; # TODO
      listen = [
        {
          ip = "127.0.0.1";
          port = 8089;
          ssl = false;
        }
      ];
    };

    database = {
      type = "mysql";
      createLocally = true;
    };

    # Administrator account username is admin.
    # Set initial password to "cardbotnine" for the account admin.
    passwordFile = /run/agenix/mediawiki;
    extraConfig = ''
      # Disable anonymous editing
      $wgGroupPermissions['*']['edit'] = false;
      # Disable new user registration
      $wgGroupPermissions['*']['createaccount'] = false;
    '';

    extensions = {
      # some extensions are included and can enabled by passing null
      VisualEditor = null;

      # https://www.mediawiki.org/wiki/Extension:TemplateStyles
      TemplateStyles = pkgs.fetchzip {
        url = "https://extdist.wmflabs.org/dist/extensions/TemplateStyles-REL1_40-5c3234a.tar.gz";
        hash = "sha256-IygCDgwJ+hZ1d39OXuJMrkaxPhVuxSkHy9bWU5NeM/E=";
      };
    };
  };
}
