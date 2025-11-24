{
  gpgSign ? true,
}:
{
  enable = true;
  settings = {
    user.name = "mmkaram";
    user.email = "mahdykaram@outlook.com";
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
