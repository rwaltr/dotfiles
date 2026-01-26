# 🚀 rwaltr's dotfiles

<div align="center">
  <img src="https://raw.githubusercontent.com/rwaltr/branding/refs/heads/master/vector/logoisolated.png"
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
- [Design Choices](#-design-choices)
- [Future Plans](#-future-plans)

## 🎯 Overview

This is my personal dotfiles repository, designed to provide a consistent development environment across:

- **Linux workstations** (Fedora/Universal Blue)
- **macOS** (work machine, minimal support)
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
- 🔄 **Zsh** - macOS compatibility bridge (shares Bash config)

### User-Space Only

This repo does **not** manage:

- ❌ Host NetworkManager configurations
- ❌ Systemd services (host level)
- ❌ Server/system administration
- ❌ Package installation on host

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

**Coming Soon**: Auto-install mise, Homebrew, and Flatpaks during init

### Option 2: Bootstrap Without Chezmoi

```bash
# Self-contained installer (downloads chezmoi)
sh -c "$(curl -fsLS https://raw.githubusercontent.com/rwaltr/dotfiles/main/install.sh)"
```

### Option 3: In a Container

```bash
# Quick ephemeral environment (Docker/Podman)
podman run -it --rm fedora:latest bash -c "
  dnf install -y git curl &&
  sh -c \"\$(curl -fsLS https://raw.githubusercontent.com/rwaltr/dotfiles/main/install.sh)\"
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

#### Zsh (macOS Bridge)

**Use for**: macOS compatibility (when Fish isn't an option)

**Strengths**:

- Shares Bash configuration (POSIX compatible)
- Minimal maintenance
- Smoother transition for Bash users

**Configuration**:

- Sources from `~/.config/bashrc.d/` (shared with Bash)
- Minimal Zsh-specific setup

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
│   ├── .chezmoiexternal.yaml  # External asset management
│   ├── .chezmoiignore    # Files to skip
│   │
│   ├── dot_config/
│   │   ├── fish/         # Fish shell (15+ modular files)
│   │   │   ├── config.fish
│   │   │   ├── conf.d/   # Auto-loaded configs
│   │   │   └── functions/
│   │   │
│   │   ├── bashrc.d/     # Modular Bash configs (17 files)
│   │   │   ├── 0.*.sh    # Core (load order)
│   │   │   └── *.sh      # Tool-specific
│   │   │
│   │   ├── nvim/         # Neovim Lua config
│   │   ├── wezterm/      # Terminal config
│   │   ├── mise/         # mise configuration
│   │   └── ...
│   │
│   └── dot_local/
│       └── bin/          # Custom scripts
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

**vs Homebrew**: Homebrew is for global tools used everywhere (kubectl, jq, fzf, etc.),
while mise handles per-project versions (Node 18 in project A, Node 20 in project B).

### Why Container-First?

**Goal**: Run this environment anywhere:

- 🖥️ **Workstation**: Full setup with GUI tools
- 📦 **Container**: Lightweight dev environment
- ☸️ **K8s Debug Pod**: Familiar shell in production (future)
- 🍎 **macOS**: Work machine compatibility

**Benefits**:

- No system pollution
- Immutable OS friendly
- Portable and reproducible
- Same environment everywhere

## 🔮 Future Plans

### In Progress

- [ ] **Distrobox Assemble**: Rebuild pi AI agent environment on any machine
- [ ] **Auto-install during init**: mise, Homebrew, Flatpaks
- [ ] **Kubernetes debug container**: Run dotfiles in `kubectl debug` pods

### Ideas

- [ ] **Wezterm sessionizer** integration with pi agent for long-running tasks
- [ ] **Container image**: Pre-built Docker/Podman image with full setup
- [ ] **macOS improvements**: Better Homebrew integration
- [ ] **Nushell integration**: Deeper data processing workflows

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
