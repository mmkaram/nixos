{
  identityPaths = ["/home/dd0k/.ssh/id_rsa"];
  secrets = {
    password = {
      file = ./secrets/password.age;
      owner = "dd0k";
      group = "users";
      mode = "600";
    };
    spotifyClientId = {
      file = ./secrets/secret1.age; # Path to your encrypted secret file
      owner = "dd0k"; # Owner of the secret file
      group = "users"; # Group of the secret file
      mode = "600"; # Permissions for the secret file
    };
    gemini = {
      file = ./secrets/gemini.age;
      path = "/run/agenix/gemini";
      owner = "dd0k";
      group = "users";
      mode = "600";
    };
  };
}
