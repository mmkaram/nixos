{pkgs, ...}:
pkgs.vimUtils.buildVimPlugin {
  name = "neo-tree.nvim";
  version = "2025-03-27";
  src = pkgs.fetchFromGitHub {
    owner = "nvim-neo-tree";
    repo = "neo-tree.nvim";
    rev = "69f798bf9493b84df660ac3c6b2fc03e23956d25";
    sha256 = "sha256-ny5D878LbmaMn9djwM9yRnW4xpdXf6ye7wa7JSnLy3s=";
  };
  doCheck = false;
}
