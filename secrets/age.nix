{
  identityPaths = [ "/home/dd0k/.ssh/id_rsa" ];
  secrets = {
    password = {
      file = ./password.age;
      owner = "dd0k";
      group = "users";
      mode = "600";
    };
    openrouter = {
      file = ./openrouter.age;
      path = "/run/agenix/openrouter";
      owner = "dd0k";
      group = "users";
      mode = "600";
    };
    cloudflaresecret = {
      file = ./cloudflaresecret.age;
      path = "/run/agenix/cloudflaresecret";
      owner = "dd0k";
      group = "users";
      mode = "600";
    };
    tycho = {
      file = ./tycho.age;
      path = "/run/agenix/tycho";
      owner = "dd0k";
      group = "users";
      mode = "600";
    };
    atuin = {
      file = ./atuin.age;
      path = "/run/agenix/atuin";
      owner = "dd0k";
      group = "users";
      mode = "600";
    };
  };
}
