{
  identityPaths = ["/home/dd0k/.ssh/id_rsa"];
  secrets = {
    password = {
      file = ./password.age;
      owner = "dd0k";
      group = "users";
      mode = "600";
    };
    spotifyClientId = {
      file = ./secret1.age;
      owner = "dd0k";
      group = "users";
      mode = "600";
    };
    gemini = {
      file = ./gemini.age;
      path = "/run/agenix/gemini";
      owner = "dd0k";
      group = "users";
      mode = "600";
    };
  };
}
