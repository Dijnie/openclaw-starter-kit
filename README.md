<p align="center">
  <img src="https://github.com/openclaw.png" alt="OpenClaw" width="120" />
</p>

# OpenClaw Starter Kit

A ready-to-use devcontainer for [OpenClaw](https://github.com/openclaw/openclaw) — your personal AI agent gateway that connects Claude, GPT, or any LLM to Telegram, WhatsApp, Discord, and more.

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://github.com/codespaces/new?hide_repo_select=true&ref=main&repo=Dijnie/openclaw-starter-kit)
[![Open in Firebase Studio](https://cdn.idx.dev/btn/open_dark_32.svg)](https://studio.firebase.google.com/new?template=https://github.com/Dijnie/openclaw-starter-kit)

---

## Dev Environment

This devcontainer installs OpenClaw via the official installer (`https://openclaw.ai/install.sh`) inside a pre-configured Node 22 environment.

**Included:**
- Node.js 22 (bookworm)
- GitHub CLI
- Docker-in-Docker (for sandbox isolation)
- Ports `18789` (Gateway) and `18790` (Bridge) forwarded automatically
- VS Code extensions: ESLint, Prettier, Docker, GitHub Copilot, Jupyter

On container creation, `setup.sh` runs automatically. It:
1. Installs OpenClaw via the official installer (`--no-onboard`)
2. Pre-creates `~/.openclaw/openclaw.json` with `allowedOrigins: ['*']` so the Control UI is accessible from Codespaces/Firebase Studio
3. Symlinks `.openclaw/` in the workspace so state persists across container rebuilds

## Getting Started

### 1. Open in Codespaces or VS Code

Click a badge above, or clone this repo and reopen in VS Code with the Dev Containers extension.

### 2. Follow the step-by-step notebook

Open [tutorial.ipynb](tutorial.ipynb) and follow along from top to bottom. Each step has a bash command to run in the terminal.

The notebook covers:

| Step | What it does |
|------|-------------|
| **1 — Check install** | `openclaw --version` |
| **2 — Onboard wizard** | `openclaw onboard --install-daemon` — configure AI provider, channels, and install daemon |
| **3 — Open Dashboard** | `openclaw dashboard` — get token URL for the Control UI |
| **4 — Pair devices** | `openclaw devices list` / `openclaw devices approve <id>` |

### Dashboard access in Codespaces / Firebase Studio

`openclaw dashboard` prints a URL like:
```
http://127.0.0.1:18789/?token=xxxxxxxx
```

Since `127.0.0.1` is not directly reachable in cloud environments:

1. Copy the **token** from the URL (the part after `?token=`)
2. Open the **Ports** tab at the bottom of the screen
3. Find port **18789** → click the **🌐** icon to open the Control UI
4. Append `?token=<token>` to the opened URL and press Enter

## Environment Variables

The devcontainer pre-sets the following variable:

| Variable | Value |
|---|---|
| `OPENCLAW_STATE_DIR` | `/home/node/.openclaw` |

See the [OpenClaw docs](https://docs.openclaw.ai) for the full variable reference.

## Ports

| Port | Service |
|---|---|
| `18789` | OpenClaw Gateway (HTTP + WebSocket) |
| `18790` | OpenClaw Bridge |

## Useful commands

| Command | Description |
|---------|-------------|
| `openclaw gateway status` | Check if the gateway is running |
| `openclaw gateway run --port 18789` | Start gateway manually if daemon is not running |
| `openclaw dashboard` | Print Dashboard URL with access token |
| `openclaw doctor` | Diagnose issues |
| `openclaw configure` | Change configuration |
| `openclaw update` | Update to a newer version |

## Docs

- [Getting started](https://docs.openclaw.ai/start/getting-started)
- [Onboarding wizard](https://docs.openclaw.ai/start/wizard)
- [Models & providers](https://docs.openclaw.ai/concepts/models)
- [Docker setup](https://docs.openclaw.ai/install/docker)
- [Updating](https://docs.openclaw.ai/install/updating)
