{
  buildNpmPackage,
  fetchFromGitHub,
}:
buildNpmPackage rec {
  pname = "prisma-language-server";
  version = "6.4.0";

  src = fetchFromGitHub {
    owner = "prisma";
    repo = "language-tools";
    rev = "f43eab733853aaa7d98c23f5864ed9b781f82175";
    hash = "sha256-GDpKzDLWy0uZNJHpX44Xi8CoWHqIS+oLdRqnOj/XAds=";
  };

  npmDepsHash = "sha256-YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY";

  postPatch = ''
    cp ${./package-lock.json} ./package-lock.json
  '';

  npmFlags = ["--ignore-scripts"];
}
