{ config, ... }:

{
  services.microbin = {
    enable = true;
    passwordFile = config.age.secrets.microbin.path;

    settings = {
      MICROBIN_BIND = "127.0.0.1";
      MICROBIN_PORT = 9090;
      MICROBIN_HIDE_LOGO = true;
    };
  };
}
