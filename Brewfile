# Brewfile — managed by chezmoi
# Update with: brew bundle dump --file=path/to/Brewfile --all --describe --force
#
# brew bundle install --file=this-file  handles:
#   - brew formulas (CLI tools, Linux bottled)
#   - flatpak apps  (Linux only, silently skipped on macOS)
#   - taps          (both platforms)

# ── Taps ──────────────────────────────────────────────────────────────────────
tap "ublue-os/tap"
tap "ublue-os/experimental-tap"

# ── CLI tools (brew formula — Linux bottled) ───────────────────────────────────

# Tool version manager — PRIMARY bootstrap tool (installs all other dev tools)
brew "mise"

# Shells
brew "fish"

# Secrets
brew "age"
brew "sops"

# Core utilities
brew "git"
brew "curl"
brew "ripgrep"
brew "fd"
brew "jq"
brew "fzf"
brew "bat"
brew "eza"
brew "zoxide"

# Shell enhancements
brew "starship"
brew "atuin"

# Editor (CLI)
brew "neovim"

# System monitoring (TUI)
brew "btop"

# ── Fonts (casks — install to ~/.local/share/fonts/ on Linux, ~/Library/Fonts on macOS) ──

# WezTerm primary fonts (wezterm.lua: font_with_fallback)
cask "font-iosevka-term-nerd-font"        # IosevkaTerm Nerd Font — primary terminal font
cask "font-iosevka"                       # Iosevka — base family fallback
cask "font-0xproto-nerd-font"             # 0xProto Nerd Font — secondary terminal font

# Other installed fonts (tracked for reproducibility)
cask "font-hack-nerd-font"                # Hack Nerd Font
cask "font-fantasque-sans-mono-nerd-font" # Fantasque Sans Mono Nerd Font
cask "font-meslo-lg-nerd-font"            # MesloLGS — common prompt font
cask "font-monocraft"                     # Monocraft — Minecraft-inspired
cask "font-miracode"                      # Miracode

# ── Flatpaks (Linux only — silently skipped on macOS) ─────────────────────────

# Notes / Productivity
flatpak "md.obsidian.Obsidian"
flatpak "org.mozilla.Thunderbird"
flatpak "org.mozilla.firefox"
flatpak "org.libreoffice.LibreOffice"
flatpak "io.github.Qalculate.qalculate-qt"
flatpak "org.gnome.meld"

# Media
flatpak "org.videolan.VLC"
flatpak "io.mpv.Mpv"

# Creative / 3D
flatpak "org.inkscape.Inkscape"
flatpak "org.freecad.FreeCAD"
flatpak "io.github.softfever.OrcaSlicer"

# Development
flatpak "dev.zed.Zed"
flatpak "io.podman_desktop.PodmanDesktop"

# Audio
flatpak "org.rncbc.qpwgraph"

# Security
# NOTE: op CLI installed via mise (aqua:1password/cli), NOT via flatpak
# Socket access for CLI auth fixed by chezmoi script: run_onchange_after_31_1password_overrides
flatpak "com.onepassword.OnePassword"

# Terminals
# NOTE: wezterm has no Linux brew bottle — flatpak only
flatpak "org.wezfurlong.wezterm"

# Gaming (flatpak on immutable systems; Steam → distrobox on ublue)
flatpak "dev.vencord.Vesktop"
flatpak "com.heroicgameslauncher.hgl"
flatpak "net.lutris.Lutris"
flatpak "net.davidotek.pupgui2"
