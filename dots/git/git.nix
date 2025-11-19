{
  gpgSign ? true,
}:
{
  enable = true;
  userName = "mmkaram";
  userEmail = "mahdykaram@outlook.com";
  extraConfig = {
    gpg.format = "ssh";
    user.signingkey = "~/.ssh/id_ed25519_sk";
    commit.gpgSign = gpgSign;
    push.autoSetupRemote = true;
    init = {
      defaultBranch = "main";
      safe.directory = "/etc/nixos";
      push.autoSetupRemote = true;
    };
  };
}
