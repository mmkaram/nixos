{ }:
{
  enable = true;
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
    host prod
        hostname 172.19.134.119
        proxyjump corn-syrup
        user ubuntu
  '';
}
