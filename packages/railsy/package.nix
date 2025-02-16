{
  lib,
  rustPlatform,
  pkg-config,
  openssl,
  fetchurl,
}:
rustPlatform.buildRustPackage rec {
  pname = "railsy";
  version = "0.1.1";

  src = fetchurl {
    url = "https://crates.io/api/v1/crates/${pname}/${version}/download";
    sha256 = "sha256-5i0hjgNoflOIoOguQEpHZMQF6RPpxNnulbpwu35CHDc=";
  };

  cargoHash = "sha256-jtBw4ahSl88L0iuCXxQgZVm1EcboWRJMNtjxLVTtzts=";

  buildInputs = [
    openssl
  ];

  nativeBuildInputs = [
    pkg-config
  ];

  PKG_CONFIG_PATH = "${openssl.dev}/lib/pkgconfig";

  meta = {
    description = "Temporary email client in Rust";
    homepage = "https://mmkaram.github.io/railsy.html";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [mmkaram];
    platforms = lib.platforms.unix;
  };
}
