{
  ...
}:
{
  services.sonarr = {
    enable = true;
    openFirewall = false;
  };

  # Bind Sonarr UI to localhost only (NixOS uses systemd override)
  systemd.services.sonarr.serviceConfig = {
    # Sonarr listens on 8989 by default; force localhost bind
    Environment = [ "SONARR__BINDADDRESS=127.0.0.1" ];
  };

  # Directories Sonarr + qBittorrent will need
  systemd.tmpfiles.rules = [
    "d /srv/library/shows 2775 sonarr users -"
    "d /srv/downloads 2775 qbt users -"
    "d /srv/downloads/incomplete 2775 qbt users -"
    "d /srv/downloads/complete 2775 qbt users -"
  ];

  # If you want Sonarr to be able to read from qBittorrent's completed dir
  # and import into shows, the simplest shared-group model is:
  users.groups.media = { };
  users.users.sonarr.extraGroups = [
    "media"
    "users"
  ];
  users.users.qbt.extraGroups = [
    "media"
    "users"
  ];
  users.users.dd0k.extraGroups = [
    "media"
    "users"
  ];

  # Optional: enforce group-writable creation for Sonarr
  systemd.services.sonarr.serviceConfig.UMask = "0002";
}
