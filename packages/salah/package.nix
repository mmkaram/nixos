{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "salah";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "mmkaram";
    repo = "salah";
    rev = "main";        # Branch name or specific commit hash
    sha256 = "sha256-5n0ixwFQRq+Hj0FOkou+L3kP7U23kzkCL5ediSXkYxw=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp ${src}/salah $out/bin/salah  # Adjust to your script's filename
    chmod +x $out/bin/salah                    # Make it executable
  '';

  meta = with lib; {
    description = "Simple bash script to get prayer times from the terminal";
    homepage = "https://github.com/mmkaram/salah";
    platforms = platforms.unix;
  };
}
