{
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "salah";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "mmkaram";
    repo = "salah";
    rev = "1f2458f42f1c9b676296f9c832a1e2fe293ba795";
    sha256 = "sha256-1LJ1Hkohn7gmgPo8OtKIL6eQp4ldMQo3P+vRV02iIGI=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp ${src}/salah $out/bin/salah
    chmod +x $out/bin/salah
  '';

  meta = with lib; {
    description = "Simple bash script to get prayer times from the terminal";
    homepage = "https://github.com/mmkaram/salah";
    platforms = platforms.unix;
  };
}
