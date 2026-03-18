{ ... }:
{
  enable = true;
  enableDefaultConfig = false;

  matchBlocks."*" = {
    # forwardAgent = false;
    # serverAliveInterval = 0;
  };

  extraConfig = ''
    Host gcp-t4
    	HostName 34.67.251.85
    	User mmkaram
    	IdentityFile ~/.ssh/agr1.pem
  '';
}
