# 🚀 rwaltr's dotfiles

<div align="center">
  <img src="https://raw.githubusercontent.com/rwaltr/branding/refs/heads/master/vector/logo.svg"
       alt="rwaltr logo" width="200"/>
</div>

> Container-first, multi-shell dotfiles for Linux power users with a Kubernetes & container workflow focus

[![Chezmoi](https://img.shields.io/badge/managed%20with-chezmoi-blue?style=flat-square)](https://www.chezmoi.io/)
[![mise](https://img.shields.io/badge/tooling-mise-orange?style=flat-square)](https://mise.jdx.dev/)
[![Fish Shell](https://img.shields.io/badge/shell-fish-green?style=flat-square)](https://fishshell.com/)
[![License](https://img.shields.io/badge/license-personal-lightgrey?style=flat-square)](LICENSE)

## 📋 Table of Contents

- [Overview](#-overview)
- [Philosophy](#-philosophy)
- [Features](#-features)
- [Quick Start](#-quick-start)
- [Shell Strategy](#-shell-strategy)
- [Project Structure](#-project-structure)
- [Development Workflow](#%EF%B8%8F-development-workflow)
- [Backups](#-backups)
- [Bisync](#-bisync)
- [Design Choices](#-design-choices)
- [Future Plans](#-future-plans)

## 🎯 Overview

This is my personal dotfiles repository, designed to provide a consistent development environment across:

- **Linux workstations** (Fedora/Universal Blue)
- **Container environments** (Distrobox, Podman, Docker)
- **Future**: Kubernetes debug pods (coming soon!)

**Target Audience**: Linux power users who work with containers, Kubernetes, and need a portable, consistent
shell environment anywhere.

## 💡 Philosophy

### Container-First Design

Everything is designed to run in userspace and work seamlessly in containerized environments:

- ✅ **No system-level configuration** - Works on immutable OSes (Fedora Atomic, etc.)
- ✅ **Portable** - Same environment in Distrobox, Podman, or bare metal
- ✅ **Self-contained** - All tools managed via mise, no root required
- ✅ **Future-proof** - Ready for Kubernetes debug containers

### Multi-Shell by Purpose

Different shells for different tasks, not just preference:

- 🐚 **Fish** - Primary interactive shell (user-friendly, modern)
- 📜 **Bash** - Scripting and automation (universal, POSIX)
- 📊 **Nushell** - Data processing (structured pipelines)

### User-Space Only

This repo does **not** manage:

- ❌ Host NetworkManager configurations
- ❌ Host-level systemd services (system units)
- ❌ Server/system administration
- ❌ Host package installation (no pacman/apt/dnf)

This keeps configs portable and safe for immutable operating systems.

## ✨ Features

### 🔧 Development Tools

- **Editor**: Neovim (Lua-based configuration)
- **Terminal**: Wezterm with sessionizer
- **Shell Tools**: Starship prompt, Carapace completions, eza, bat, fzf
- **Version Management**: mise (formerly rtx)
- **Git Hooks**: hk (high-performance, mise-integrated)

### ☸️ Kubernetes & Containers

- **Container Runtime**: Podman + Distrobox
- **K8s Tools**: kubectl, krew plugins
- **Custom kubeconfig manager** (Fish shell)

  ```fish
  # Automatically merges configs from ~/.kube/clusters/
  set-kubeconfig          # Load all configs
  isolate-kubeconfig path # Use single config
  append-kubeconfig path  # Add to current context
  store-kubeconfig path   # Save to clusters dir
  ```

### 🔐 Secrets Management

- **1Password CLI integration** via Chezmoi templates
- Personal use only (not for team/shared secrets)

### 📦 Package Management

- **CLI Tools**: Homebrew (general use), mise (project-specific versions)
- **GUI Apps**: Flatpak (Linux only)
- **Containers**: Podman + Distrobox exported apps
- **Language Tools**: Managed by mise per-project (Python, Node, Go, Rust, etc.)

### 🤖 Bootstrap Automation

`chezmoi apply` on a fresh ublue/immutable Linux system automatically:

1. **Installs Homebrew** (`run_once_before_10`) — Linuxbrew in `/home/linuxbrew`
2. **Installs Tailscale** (`run_once_before_20`) — via official install script, skipped if present or ephemeral
3. **Runs `brew bundle`** (`run_always_after_30`) — CLI tools, fonts; rendered from `Brewfile` template
4. **Configures 1Password flatpak** (`run_onchange_after_31`) — filesystem overrides for SSH agent + CLI daemon
5. **Installs Flatpaks** (`run_always_after_35`) — system-wide from `flatpaks.txt` template; additive only
6. **Installs OrcaSlicer** (`run_always_after_36`) — personal machines; version-checked, flatpak bundle
7. **Runs `mise install`** (`run_onchange_after_50`) — installs all tools in `~/.config/mise/config.toml`
8. **Reloads systemd** (`run_always_after_99`) — picks up new/changed user units

All scripts are idempotent and additive — safe to re-run on every `chezmoi apply`.

### 🎨 Desktop Environments

- **Niri** (Wayland tiling compositor)
- **KDE Plasma** (full desktop)

## 🚀 Quick Start

### Option 1: With Chezmoi Installed

```bash
# Initialize and apply dotfiles
chezmoi init rwaltr
chezmoi apply
```

On first apply, chezmoi will automatically install Homebrew, Tailscale,
brew bundle (CLI tools + fonts), Flatpaks, and mise tools.

### Option 2: Bootstrap Without Chezmoi

```bash
# Self-contained installer (downloads chezmoi)
sh -c "$(curl -fsLS https://raw.githubusercontent.com/rwaltr/dotfiles/master/install.sh)"
```

### Option 3: In a Container

```bash
# Quick ephemeral environment (Docker/Podman)
podman run -it --rm fedora:latest bash -c "
  dnf install -y git curl &&
  sh -c \"\$(curl -fsLS https://raw.githubusercontent.com/rwaltr/dotfiles/master/install.sh)\"
"

# Persistent Distrobox environment (Linux only)
distrobox create --image ghcr.io/ublue-os/bluefin-cli:latest --name dev
distrobox enter dev
chezmoi init rwaltr && chezmoi apply
```

## 🐚 Shell Strategy

### Why Multiple Shells?

Each shell serves a specific purpose based on its strengths:

#### Fish (Primary Interactive)

**Use for**: Daily interactive work, command exploration, quick tasks

**Strengths**:

- Modern, intuitive syntax
- Excellent tab completion
- Syntax highlighting out-of-the-box
- User-friendly interactive features

**Example Config**:

```fish
# ~/.config/fish/config.fish
# Modular configuration via conf.d/*.fish
# Custom functions in functions/*.fish
```

#### Bash (Universal Scripting)

**Use for**: Scripts, automation, CI/CD, compatibility

**Strengths**:

- Available everywhere (including containers, minimal systems)
- POSIX compatible
- Industry standard for scripting

**Example Structure**:

```bash
# Modular configuration in ~/.config/bashrc.d/
# Loaded alphabetically:
# - 0.*.sh (core setup)
# - *.sh (tool configs)
```

#### Nushell (Data Processing)

**Use for**: Log analysis, data transformation, structured pipelines

**Strengths**:

- Structured data (tables, records)
- Type-aware commands
- SQL-like queries

**Example Use Case**:

```nu
# Parse JSON logs with structured queries
cat logs.json | from json | where status == 500 | length
```

## 📁 Project Structure

```
dotfiles/
├── .chezmoiroot          # Points source to home/ directory
├── install.sh            # Bootstrap script (no chezmoi required)
├── mise.toml             # Development tools & tasks
├── hk.pkl                # Git hooks configuration
├── .markdownlint-cli2.jsonc  # Markdown linting rules
│
├── home/                 # Chezmoi source directory (becomes ~/)
│   ├── .chezmoiexternal.yaml  # External assets (OrcaSlicer bundle)
│   ├── .chezmoiignore    # Files to skip (personal-only gating)
│   ├── .chezmoi.yaml.tmpl    # Machine flags: personal, work, headless, ephemeral
│   │
│   ├── .chezmoiscripts/
│   │   ├── before/       # Pre-apply: homebrew, tailscale, common dirs
│   │   └── after/        # Post-apply: brew bundle, flatpaks, mise, systemd reload
│   │
│   ├── .chezmoitemplates/
│   │   ├── Brewfile       # CLI tools + fonts (segmented by flags)
│   │   └── flatpaks.txt   # Flatpak app IDs (segmented by flags)
│   │
│   ├── dot_config/
│   │   ├── fish/          # Fish shell (primary interactive)
│   │   ├── bashrc.d/      # Modular Bash configs
│   │   ├── nushell/       # Nushell data processing
│   │   ├── nvim/          # Neovim Lua config
│   │   ├── wezterm/       # Terminal config
│   │   ├── mise/          # Global mise tool config
│   │   ├── niri/          # Niri Wayland compositor
│   │   ├── bisync/        # rclone bisync profiles (LOCAL/REMOTE env pairs)
│   │   ├── containers/systemd/  # Podman quadlets (resticprofile)
│   │   ├── systemd/user/  # User systemd units + timers
│   │   └── resticprofile/ # Backup profiles (personal only)
│   │
│   └── dot_local/
│       └── bin/           # Custom scripts:
│                          #   auto-bisync, bisync-now, gamingctl,
│                          #   virtcontainerctl, restic-setup-creds, ssh-multi
│
├── AGENTS.md             # Comprehensive context for AI agents
└── README.md             # This file
```

### Key Files

- **`mise.toml`** - Development tools, linting/formatting tasks
- **`hk.pkl`** - Git pre-commit/pre-push hooks (delegates to mise)
- **`AGENTS.md`** - Deep dive for AI coding assistants (like pi!)
- **`home/dot_config/bashrc.d/`** - 17 modular Bash scripts
- **`home/dot_config/fish/`** - 15+ Fish shell modules

## 🛠️ Development Workflow

### Linting & Formatting

Powered by `mise` tasks and `hk` git hooks:

```bash
# Run all linters
mise run lint

# Run all formatters
mise run format

# Individual linters
mise run lint:shell      # shellcheck
mise run lint:fish       # fish --no-execute
mise run lint:lua        # stylua
mise run lint:yaml       # yamllint
mise run lint:toml       # taplo
mise run lint:markdown   # markdownlint-cli2

# Individual formatters
mise run format:shell    # shfmt
mise run format:lua      # stylua
mise run format:toml     # taplo
```

### Git Hooks (via hk)

Automatically runs linters on commit/push:

```bash
# Install hooks (one-time)
mise run hk:install

# Manually check staged files
mise run check

# Auto-fix issues in staged files
mise run hk:fix

# Hooks run automatically
git commit -m "feat: something"  # ← linters run here

# Skip hooks if needed (emergency only)
HK=0 git commit -m "emergency fix"
```

**How it works**: `hk` delegates to `mise run lint`, ensuring git hooks and manual checks are identical.

### Managing Dotfiles

```bash
# Check what would change
chezmoi diff

# Apply changes
chezmoi apply

# Edit a file (opens in $EDITOR)
chezmoi edit ~/.config/fish/config.fish

# Add a new file to management
chezmoi add ~/.config/newapp/config.toml

# Update from repository
chezmoi update

# See status
chezmoi status
```

### Adding New Tools

```bash
# Global tools via Homebrew (available everywhere)
brew install kubectl kubectx jq fzf ripgrep

# Project-specific versions via mise
cd ~/project
mise use node@20 python@3.12

# Or add to project's .mise.toml:
# [tools]
# node = "20"
# python = "3.12"

# Install tools
mise install

# Verify
mise list
```

## 💾 Backups

Home directory backups are managed via [resticprofile](https://creativeprojects.github.io/resticprofile/) —
a profile-based wrapper around [restic](https://restic.net/).

### How it works

- **Profile config**: `~/.config/resticprofile/profiles.toml` (managed by chezmoi, personal machines only)
- **Repo**: `sftp:mouse:backups/<hostname>/home` — per-host repo on the mouse server over SFTP/Tailscale
- **SSH auth**: 1Password SSH agent (`~/.1password/agent.sock`)
- **Schedule**: Hourly via user systemd timer (`resticprofile@home.timer`), starts after `tailscale0` is up
- **Retention**: 24 hourly, 7 daily, 4 weekly, 12 monthly, 3 yearly snapshots
- **Credentials**: Per-host password stored at `~/.config/resticprofile/password` (mode 600, not in git)

### Podman quadlet

resticprofile runs in a rootless Podman container via a systemd quadlet — no local install required.

```
systemd timer → resticprofile@<profile>.service → podman run ghcr.io/creativeprojects/resticprofile
```

The quadlet (`~/.config/containers/systemd/resticprofile@.container`) mounts:

- `~` — backup source and SSH keys
- `~/.config/resticprofile` — profile config and credentials
- `~/.1password/agent.sock` — 1Password SSH agent for SFTP auth

### What's excluded

Caches, Steam, container storage, build artifacts (`node_modules`, `target`, `.cargo`),
`~/src` (on GitHub), `~/Downloads`, large disk images (`*.iso`, `*.qcow2`).

### First-time setup (per host)

```bash
# 1. Set the repo password — stored at ~/.config/resticprofile/password
restic-setup-creds

# 2. Initialize the restic repo on the remote
systemctl --user start resticprofile@home.service
# (resticprofile initialize = true handles this automatically on first run)

# 3. Enable the timer
systemctl --user enable --now resticprofile@home.timer

# 4. Watch logs
journalctl --user -u resticprofile@home.service -f
```

### Adding a new backup profile

Add a new profile to `profiles.toml` inheriting from `base`:

```toml
[documents]
inherit    = "base"
repository = "sftp:mouse:backups/{{ "{{" }} .chezmoi.hostname {{ "}}" }}/documents"

[documents.backup]
source = ["~/Documents"]
```

Then add and enable a timer:

```bash
cp ~/.config/systemd/user/resticprofile@home.timer \
   ~/.config/systemd/user/resticprofile@documents.timer
systemctl --user enable --now resticprofile@documents.timer
```

### Future: S3 backend

When mouse gets an S3-compatible backend, add a second profile pointing at it —
the `base` excludes and retention policy inherit automatically.

## 🔄 Bisync

Two-way file synchronization between local directories and a remote server using
[rclone bisync](https://rclone.org/bisync/), with profile-based configuration.

### Bisync details

- **Profiles**: `~/.config/bisync/*.env` — each file defines a `LOCAL` and `REMOTE` path pair
- **Transport**: SFTP to the `mouse` server over Tailscale with SSH key auth
- **Tools**: `auto-bisync` (watch mode) and `bisync-now` (ad-hoc sync)
- **Backups**: Conflict/overwrite backups stored in `~/.local/share/bisync-backups/`

### Configured profiles

| Profile | Local | Remote |
| --- | --- | --- |
| books | `~/Books` | `mouse:/var/tank/home/rwaltr/Books` |
| documents | `~/Documents` | `mouse:/var/tank/home/rwaltr/Documents` |
| games | `~/Games` | `mouse:/var/tank/home/rwaltr/Games` |
| music | `~/Music` | `mouse:/var/tank/home/rwaltr/Music` |
| pictures | `~/Pictures` | `mouse:/var/tank/home/rwaltr/Pictures` |
| videos | `~/Videos` | `mouse:/var/tank/home/rwaltr/Videos` |

### Usage

```bash
# List available profiles
bisync-now list

# Sync a specific profile
bisync-now documents

# Sync all profiles
bisync-now all

# Watch mode — auto-sync on file changes (requires inotify-tools)
auto-bisync ~/Documents :sftp,host=mouse,key_file=~/.ssh/id_ed25519:/var/tank/home/rwaltr/Documents watch

# One-shot sync (used by bisync-now internally)
auto-bisync ~/Documents :sftp,host=mouse,key_file=~/.ssh/id_ed25519:/var/tank/home/rwaltr/Documents once

# First-time resync (resolves empty tracking state)
auto-bisync ~/Documents :sftp,host=mouse,key_file=~/.ssh/id_ed25519:/var/tank/home/rwaltr/Documents resync
```

### Systemd integration

A templated user service (`bisync@.service`) runs `auto-bisync` in watch mode for any profile.
It waits for the Tailscale interface before starting.

```bash
# Enable continuous sync for a profile
systemctl --user enable --now bisync@documents.service

# Enable all profiles
for p in books documents games music pictures videos; do
  systemctl --user enable --now bisync@${p}.service
done

# Check status
systemctl --user status bisync@documents.service

# View logs
journalctl --user -u bisync@documents.service -f
```

### Requirements

- `rclone` — installed via Homebrew/mise
- `inotify-tools` — for watch mode
- SSH key at `~/.ssh/id_ed25519` with access to `mouse`
- Tailscale — service waits for `tailscale0` interface

## 🤔 Design Choices

### Why Chezmoi?

**vs Nix**: More complexity than needed for dotfiles alone. Chezmoi hits the sweet spot between:

- **Simplicity**: Templates, not a whole OS
- **Power**: Templating, external resources, secrets management
- **Portability**: Works on any system with a shell

**vs Stow/bare git**: Need templating for:

- Different configs per machine
- Secret injection from 1Password
- OS-specific sections

### Why Fish as Primary Shell?

- **Interactive Focus**: 90% of shell time is interactive, not scripting
- **Modern UX**: Tab completion, syntax highlighting, better defaults
- **Less Configuration**: Works great out-of-the-box
- **Still Use Bash**: For scripts where portability matters

### Why mise?

For **project-specific** version management:

- ✅ **Version Management**: Replaces asdf, nvm, rbenv, pyenv, etc. per-project
- ✅ **Task Runner**: Built-in make alternative
- ✅ **Tool Installer**: Downloads and manages CLI tools
- ✅ **Environment Management**: Per-project tool versions via `.mise.toml`

**vs Homebrew**: Homebrew is for global tools used everywhere (kubectl, jq, fzf, etc.),
while mise handles per-project versions (Node 18 in project A, Node 20 in project B).

### Why Container-First?

**Goal**: Run this environment anywhere:

- 🖥️ **Workstation**: Full setup with GUI tools
- 📦 **Container**: Lightweight dev environment
- ☸️ **K8s Debug Pod**: Familiar shell in production (future)

**Benefits**:

- No system pollution
- Immutable OS friendly
- Portable and reproducible
- Same environment everywhere

## 🔮 Future Plans

### In Progress

- [ ] **Distrobox Assemble**: Rebuild pi AI agent environment on any machine
- [ ] **Kubernetes debug container**: Run dotfiles in `kubectl debug` pods
- [ ] **First bootstrap test**: Full end-to-end test on a fresh ublue system

### Ideas

- [ ] **Wezterm sessionizer** integration with pi agent for long-running tasks
- [ ] **Container image**: Pre-built Docker/Podman image with full setup
- [ ] **Nushell integration**: Deeper data processing workflows
- [ ] **S3 backup backend**: Second restic profile pointing at S3-compatible storage

## 📚 Additional Documentation

- **[AGENTS.md](AGENTS.md)** - Comprehensive guide for AI coding assistants
  - Full project philosophy
  - File-by-file breakdown
  - Configuration patterns
  - Chezmoi workflows
  - Development tasks

## 🤝 Contributing

This is a personal repository, but feel free to:

- 💡 Open issues with questions
- 🐛 Report bugs or suggest improvements
- ⭐ Star if you find it useful!

## 📝 License

Personal use. Feel free to use as inspiration or starting point for your own dotfiles.

---

**Built with**: [Chezmoi](https://www.chezmoi.io/) • [mise](https://mise.jdx.dev/) • [Fish](https://fishshell.com/) •
[Neovim](https://neovim.io/) • [Wezterm](https://wezfurlong.org/wezterm/)
