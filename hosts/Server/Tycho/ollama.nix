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
      OLLAMA_BASE_URL = "http://127.0.0.1:11434";
      WEBUI_AUTH = "true";
    };

    stateDir = "/var/lib/open-webui";
  };
}
