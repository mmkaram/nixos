let
  secretNames = [
    "atuin"
    "cloudflaresecret"
    "mediawiki"
    "microbin"
    "mullvad-wg-address"
    "mullvad-wg-private"
    "openrouter"
    "password"
    "vaultwarden"
    "tycho"
    "syncthing"
    "nextcloud"
  ];

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
