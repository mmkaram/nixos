let
  files = builtins.attrNames (builtins.readDir ./.);

  ageFiles = builtins.filter (name: builtins.match ".*\\.age" name != null) files;

  secretNames = map (file: builtins.replaceStrings [ ".age" ] [ "" ] file) ageFiles;

  mkSecret = name: {
    file = ./. + "/${name}.age";
    path = "/run/agenix/${name}";
    owner = "dd0k";
    group = "users";
    mode = "600";
  };
in
{
  identityPaths = [ "/home/dd0k/.ssh/id_rsa" ];

  secrets = builtins.listToAttrs (
    map (name: {
      inherit name;
      value = mkSecret name;
    }) secretNames
  );
}
