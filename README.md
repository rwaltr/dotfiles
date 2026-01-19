# The dotfiles of a madman (now with less Nix)

Stuff be changing, maybe it Use Chezmoi to deploy.

# Targets to install for

## Container envs

- WofiOS/bluefin-cli
- ad-hoc container

## Plain OS

- Fedora/Ublue
- Minimal support for macos

## Package Managers

- mise/Brew for CLI tools on Linux
- Flatpak for GUI apps on Linux
- Podman for Containers on Linux
- Distrobox and exported applications for portable envs on Linux

# Desktop env

- Niri
- KDE

# artifacts to generate

- Distrobox container for quick dev use
- `chezmoi init rwaltr` with minimal input

# Secrets management

- Via OnePassword CLI for personal use only

# Not targeted

- Automatic Host System Configuration (e.g. NetworkManager, host level systemd services, etc)
- Server configuration
