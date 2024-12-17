{pkgs, ...}:
pkgs.vimUtils.buildVimPlugin {
  name = "git-dashboard-nvim";
  src = pkgs.fetchFromGitHub {
    "owner" = "mmkaram";
    "repo" = "git-dashboard-nvim";
    "rev" = "e17890289a3477f6c96e0e046d02859714fecbe2";
    "hash" = "sha256-G+qX8aOYy2PsmlPe2s9OLvSjHGWJReXqrXbdiFrAbWw=";
  };
}
