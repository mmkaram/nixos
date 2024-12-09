{
  lib,
  stdenv,
  fetchFromGitHub,
  python312Packages,
  pkgs,
}:
stdenv.mkDerivation rec {
  pname = "videomass";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "jeanslack";
    repo = "Videomass";
    rev = "v${version}";
    sha256 = "sha256-UdPQBMSa+2S9YiOqCuF2Qyw9MqsQoCljtx+4jytznLo=";
  };

  nativeBuildInputs = with python312Packages; [
    virtualenv
    wxpython
    pypubsub
    requests
    pip
  ];

  buildInputs = with pkgs; [
    ffmpeg
  ];

  buildPhase = ''
    virtualenv venv
    source venv/bin/activate
    # pip install .
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp launcher $out/bin/videomass
    chmod +x $out/bin/videomass
  '';

  meta = with lib; {
    description = "Videomass GUI for FFmpeg and youtube-dl";
    homepage = "https://github.com/jeanslack/Videomass";
    license = licenses.gpl3;
    platforms = platforms.unix;
  };
}
