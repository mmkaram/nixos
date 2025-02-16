{pkgs, ...}:
pkgs.vimUtils.buildVimPlugin {
  name = "americano.nvim";
  src = pkgs.fetchFromGitHub {
    "owner" = "cpwrs";
    "repo" = "americano.nvim";
    "rev" = "bc475da834be255fc7072f9f321b01b2a92affea";
    "hash" = "sha256-Xvv/iStyQ2LNWSnkFKLyZHFTml/ZufYveeCmQ7cHfPY=";
  };
}
