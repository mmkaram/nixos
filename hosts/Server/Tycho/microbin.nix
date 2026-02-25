{ ... }:
{
  services.microbin = {
    enable = true;
    passwordFile = "/run/agenix/microbin";
    settings = {
      MICROBIN_BIND = "127.0.0.1";
      MICROBIN_PORT = 9090;
      MICROBIN_HIDE_LOGO = true;
    };
  };
}
