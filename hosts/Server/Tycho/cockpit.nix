{ ... }:
{
  services.cockpit = {
    enable = true;
    port = 9091;
    openFirewall = true;
    showBanner = true;
  };
}
