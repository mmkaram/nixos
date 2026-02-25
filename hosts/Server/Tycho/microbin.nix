{ ... }:
{
  services.microbin = {
    enable = true;
    passwordFile = "/run/agenix/microbin";
    settings = {
      MICROBIN_BIND = "0.0.0.0";
      MICROBIN_PORT = 9090;
      MICROBIN_HIDE_LOGO = true;
    };
  };
}
