{ ... }:
{
  services.atuin = {
    enable = true;

    host = "127.0.0.1";
    port = 8888;
    openFirewall = false;

    openRegistration = false;

    path = "/var/lib/atuin";

    database = {
      createLocally = true;
    };
  };

}
