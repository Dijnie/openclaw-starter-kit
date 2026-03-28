#!/usr/bin/env bash
# Sets up the OpenClaw environment inside the devcontainer.
# Installs openclaw globally via the official install script from openclaw.ai.
set -euo pipefail

echo "==> Installing OpenClaw via official installer..."
export OPENCLAW_NO_PROMPT=1
export OPENCLAW_NO_ONBOARD=1

# Store openclaw state in the workspace so it persists across rebuilds.
# Symlink $HOME/.openclaw → workspace/.openclaw so openclaw finds it at the default path.
WORKSPACE_OPENCLAW="${GITHUB_WORKSPACE:-$(pwd)}/.openclaw"
mkdir -p "$WORKSPACE_OPENCLAW"
ln -sfn "$WORKSPACE_OPENCLAW" "$HOME/.openclaw"

# Pre-create config so installer detects existing setup and skips onboard.
# Sets allowedOrigins: ['*'] so the gateway Control UI is accessible from Codespaces.
cat > "$HOME/.openclaw/openclaw.json" << 'EOF'
{
  "gateway": {
    "controlUi": {
      "allowedOrigins": ["*"]
    }
  }
}
EOF

curl -fsSL --proto '=https' --tlsv1.2 https://openclaw.ai/install.sh | bash -s -- --no-onboard

# Ensure the installed binary is on PATH for this session
export PATH="$HOME/.local/bin:$HOME/.npm-global/bin:$PATH"

echo ""
echo "OpenClaw is ready!"
echo "  openclaw gateway --port 18789 --verbose"
echo ""
echo "  Or run the onboard wizard:"
echo "  openclaw onboard"
