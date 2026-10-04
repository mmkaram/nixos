{
  config,
  inputs,
  pkgs,
  ...
}:

let
  stablePkgs = import inputs.nixpkgs-stable {
    system = pkgs.stdenv.hostPlatform.system;
    config = config.nixpkgs.config;
  };
in

{
  hardware.nvidia-container-toolkit.enable = true;

  systemd.tmpfiles.rules = [
    "d /var/lib/comfyui 0755 dd0k users -"
    "d /var/lib/comfyui/models 0755 dd0k users -"
    "d /var/lib/comfyui/custom_nodes 0755 dd0k users -"
    "d /var/lib/comfyui/input 0755 dd0k users -"
    "d /var/lib/comfyui/output 0755 dd0k users -"
  ];

  virtualisation.oci-containers.backend = "docker";
  virtualisation.oci-containers.containers.comfyui = {
    image = "ghcr.io/lecode-official/comfyui-docker:latest";
    autoStart = true;
    ports = [ "127.0.0.1:8188:8188" ];
    volumes = [
      "/var/lib/comfyui/models:/opt/comfyui/models:rw"
      "/var/lib/comfyui/custom_nodes:/opt/comfyui/custom_nodes:rw"
      "/var/lib/comfyui/input:/opt/comfyui/input:rw"
      "/var/lib/comfyui/output:/opt/comfyui/output:rw"
    ];
    environment = {
      USER_ID = "1000";
      GROUP_ID = "100";
    };
    extraOptions = [ "--gpus=all" ];
  };

  services.ollama = {
    enable = true;
    package = stablePkgs.ollama-cuda;

    host = "0.0.0.0";
    port = 11434;

    loadModels = [
      "deepseek-r1:14b"
      "qwen3:14b"
      "x/z-image-turbo:fp8"
      "gemma4:e4b"
    ];
  };

  services.open-webui = {
    enable = true;
    package = stablePkgs.open-webui;

    host = "127.0.0.1";
    port = 8081;
    openFirewall = false;

    environment = {
      COMFYUI_BASE_URL = "http://127.0.0.1:8188";
      ENABLE_IMAGE_GENERATION = "true";
      IMAGE_GENERATION_ENGINE = "comfyui";
      OLLAMA_BASE_URL = "http://127.0.0.1:11434";
      WEBUI_AUTH = "true";
    };

    stateDir = "/var/lib/open-webui";
  };
}
