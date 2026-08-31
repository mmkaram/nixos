{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # (stable-diffusion-cpp-cuda.override { cudaSupport = true; })
    stable-diffusion-cpp-cuda
  ];

  systemd.tmpfiles.rules = [
    "d /srv/library/stable-diffusion-cpp 0750 stable-diffusion-cpp stable-diffusion-cpp -"
    "d /srv/library/stable-diffusion-cpp/models 0750 stable-diffusion-cpp stable-diffusion-cpp -"
    "d /srv/library/stable-diffusion-cpp/outputs 0750 stable-diffusion-cpp stable-diffusion-cpp -"
  ];

  users.users.stable-diffusion-cpp = {
    isSystemUser = true;
    group = "stable-diffusion-cpp";
    home = "/srv/library/stable-diffusion-cpp";
  };
  users.groups.stable-diffusion-cpp = { };

  systemd.services.stable-diffusion-cpp = {
    description = "stable-diffusion.cpp API server";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      User = "stable-diffusion-cpp";
      Group = "stable-diffusion-cpp";
      WorkingDirectory = "/srv/library/stable-diffusion-cpp";
      StateDirectory = "stable-diffusion-cpp";
      Restart = "on-failure";
      RestartSec = "10s";
      ExecStartPre = "${pkgs.coreutils}/bin/test -r /srv/library/stable-diffusion-cpp/models/model.gguf";
      ExecStart = ''
        ${pkgs.stable-diffusion-cpp-cuda}/bin/sd-server \
          --listen-ip 127.0.0.1 \
          --listen-port 7860 \
          --model /srv/library/stable-diffusion-cpp/models/model.gguf \
          --output-path /srv/library/stable-diffusion-cpp/outputs
      '';
    };
  };
}
