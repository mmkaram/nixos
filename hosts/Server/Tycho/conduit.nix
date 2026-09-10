{ config, ... }:
{
  services.matrix-conduit = {
    enable = true;
    secretFile = config.age.secrets.conduit.path;

    settings.global = {
      allow_registration = true;
      server_name = "conduit.mmkaram.dev";
      port = 1728;
      address = "::1";
      database_backend = "rocksdb";

      # TODO: Setup turn for matrix calls
      # See https://docs.conduit.rs/turn.html, and https://github.com/element-hq/synapse/blob/develop/docs/turn-howto.md for more details
      # turn_uris = [
      #  "turn:your.turn.url?transport=udp"
      #  "turn:your.turn.url?transport=tcp"
      # ];
      # turn_secret = "your secret";
    };
  };
  fileSystems."/var/lib/matrix-conduit" = {
    device = "/srv/matrix-conduit";
    options = [ "bind" ];
  };
}
