{ ... }:
{
  enable = true;
  enableDefaultConfig = false;

  matchBlocks."*" = {
    # forwardAgent = false;
    # serverAliveInterval = 0;
  };

  extraConfig = ''
    Host csuw
        HostName linux.student.cs.uwaterloo.ca
        User mkaram
        ForwardX11Trusted yes
    Host hfcs
        HostName hfcs.csclub.uwaterloo.ca
        User mkaram
    Host corn-syrup
        HostName corn-syrup.csclub.uwaterloo.ca
        User mkaram
    Host prod
        HostName 172.19.134.119
        ProxyJump corn-syrup
        User ubuntu
  '';
}
