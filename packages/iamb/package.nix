{
  rustPlatform,
  fetchFromGitHub,
  installShellFiles,
}:
rustPlatform.buildRustPackage {
  pname = "iamb";
  version = "0.0.10";

  src = fetchFromGitHub {
    owner = "ulyssa";
    repo = "iamb";
    rev = "b023e38f772f167f9c3a9e7d6dc105b2bc784a8e";
    hash = "sha256-TgkKx7NCxEXR7I6AY5CJ4fNC6BEXizJs1nt6zuik9E0=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-fAre0jrpJ63adcg4AKCYzdQtCsd0MMMcWA0RsoHo6ig=";

  nativeBuildInputs = [installShellFiles];

  postInstall = ''
    OUT_DIR=$releaseDir/build/iamb-*/out
    installManPage $OUT_DIR/iamb.{1,5}
  '';
}
