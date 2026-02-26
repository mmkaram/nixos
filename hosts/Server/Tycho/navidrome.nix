{ ... }:
{
  services.navidrome = {
    enable = true;

    settings = {
      MusicFolder = "/srv/library/music";
      DataFolder = "/srv/appdata/navidrome";

      ScanInterval = "1h";
      ScannerPurgeMissing = "always";
      SessionTimeout = "24h";
      LogLevel = "info";

      BaseURL = "https://navidrome.mmkaram.dev";
      ReverseProxyListen = true;
      ReverseProxyClientIPHeaders = [ "CF-Connecting-IP" ];
      ReverseProxyTLS = true;

      # Disable auto-import playlists
      AutoImportPlaylists = false;

      # Cover art configuration
      CoverArtProviders = [
        "local"
        "embedded"
        "lastfm"
        "fanarttv"
        "coverartarchive"
      ];
      LastFM_APIKey = "aa2d579d4c6799e7d2977aca49baefc3";
      MusicBrainzEnabled = true;
      CoverArtPriority = "cover.jpg,cover.png,folder.jpg,folder.png,front.jpg,front.png,embedded";

      # Port
      ListenPort = 4533;
    };

    user = "1000";
    group = "100";

    # Open firewall
    openFirewall = true;
  };

}
