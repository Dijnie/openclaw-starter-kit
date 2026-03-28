# Firebase Studio (IDX) dev environment for OpenClaw
# Docs: https://developers.google.com/idx/guides/customize-idx-env
{ pkgs, ... }: {
  channel = "stable-24.11";

  packages = [
    pkgs.nodejs_22
    pkgs.nodePackages.pnpm
    pkgs.curl
    pkgs.git
    pkgs.openssl
  ];

  env = {
    OPENCLAW_NO_PROMPT = "1";
    OPENCLAW_STATE_DIR = "/home/user/.openclaw";
  };

  idx = {
    extensions = [
      "ms-toolsai.jupyter"
    ];

    workspace = {
      # Runs once when the workspace is first created
      onCreate = {
        install-openclaw = "bash .devcontainer/setup.sh";
        default.openFiles = [ "tutorial.ipynb" ];
      };

      # Runs every time the workspace is reopened
      onStart = {
        start-gateway = "systemctl --user start openclaw 2>/dev/null || openclaw gateway run --port 18789 &";
      };
    };

    previews = {
      enable = true;
      previews = {
        web = {
          command = [ "openclaw" "gateway" "--port" "18789" "--bind" "all" "--verbose" ];
          manager = "web";
          env = { PORT = "18789"; };
        };
      };
    };
  };
}
