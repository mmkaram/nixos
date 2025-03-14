{
  appimageTools,
  fetchurl,
  ...
}: let
  pname = "zen";
  version = "latest";

  src = fetchurl {
    sha256 = "sha256-hZiJ8JLzLhtD1W8DAso3yBAJYhFE+nJEbQJa59AWjnU=";
    url = "https://github.com/zen-browser/desktop/releases/dc1c166ac2d88d48c47bbc01b60e7a70413e71e0/download/zen-x86_64.AppImage";
  };

  appimageContents = appimageTools.extract {
    inherit pname version src;
  };
in
  appimageTools.wrapType2 {
    inherit pname version src;

    extraInstallCommands = ''
      # Install .desktop file
      install -m 444 -D ${appimageContents}/zen.desktop $out/share/applications/${pname}.desktop
      # Install icon
      install -m 444 -D ${appimageContents}/zen.png $out/share/icons/hicolor/128x128/apps/${pname}.png
    '';

    meta = {
      platforms = ["x86_64-linux"];
    };
  }
