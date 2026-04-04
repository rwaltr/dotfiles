# Dotfiles Test Suite

Test suite for validating dotfile configurations locally and against real OS targets.

## Quick Start

```bash
# Build the test container (one-time, ~2min)
mise run test:build

# Run unit tests in container (recommended — consistent environment)
mise run test:unit

# Run unit tests locally (uses host tools, may skip tests)
mise run test:unit:local

# Lint + unit tests
mise run test

# Everything including container image tests
mise run test:all
```

## Test Layers

### Layer 1: Unit Tests (`mise run test:unit`)

Runs in a Fedora 44 container via podman for consistent tool availability.
Uses **bats-core**. 138 tests.

| File | Tests | What it covers |
|---|---|---|
| `atuin.bats` | 2 | Atuin config TOML validity |
| `bash.bats` | 5 | Bash syntax, bashrc.d sourcing |
| `chezmoi.bats` | 7 | Chezmoi structure, doctor, managed files |
| `configs.bats` | 5 | mise.toml, sops.yaml, externals, install.sh |
| `fish.bats` | 5 | Fish syntax, conf.d, functions |
| `interactive.bats` | 20 | Bash aliases/env, fish features, cross-shell consistency |
| `neovim.bats` | 8 | Lua syntax, headless startup, lazy.lua, plugins |
| `niri.bats` | 7 | KDL entrypoint, local.kdl, DMS overlay, keybindings, layout, outputs |
| `nushell.bats` | 1 | Syntax check (skips if nu not installed) |
| `scripts.bats` | 21 | Script template rendering + syntax + conditional logic |
| `security.bats` | 6 | No leaked secrets in source |
| `starship.bats` | 7 | TOML valid, palette, bash/fish integration |
| `systemd.bats` | 5 | Unit sections, ExecStart, timer schedules |
| `television.bats` | 3 | Config + cable channel TOML validity |
| `templates.bats` | 14 | All .tmpl files render, content validation |
| `tools.bats` | 14 | bat, mpv, containers, go, kube, bisync, resticprofile |
| `wezterm.bats` | 5 | Lua syntax, wezterm API references |
| `yazi.bats` | 3 | All 3 TOML configs valid |

### Layer 2: Container Image Tests (`mise run test:image`)

Runs `chezmoi apply` inside real OS container images via **podman**, validates
with **goss**.

| Target | Image | Type |
|---|---|---|
| `bootc-zirconium` | `ghcr.io/zirconium-dev/zirconium:latest` | Bootc/immutable (Fedora 44) |
| `bluefin` | `ghcr.io/ublue-os/bluefin:stable` | Bootc/immutable (Fedora 43) |

Each image target runs:
1. **Prereqs** — base image has expected tools
2. **Apply** — files placed, scripts rendered + executed twice (idempotency)
3. **Goss common** — shared assertions (files exist, bash starts, git/ssh config)
4. **Goss target-specific** — per-image checks (idempotency, fish, flatpak)
5. **Goss scripts** — brew installed, mise via brew, common dirs created

### Layer 3: VM Tests (manual)

Full end-to-end on a real Zirconium VM via libvirt. Boots a qcow2 built from
the bootc image, applies dotfiles over SSH, validates everything including
brew, flatpaks, fonts, and systemd services.

See [VM Testing](#vm-testing) below.

## Running Tests

```bash
# Build test container (one-time)
mise run test:build

# Fast: lint + unit (in container)
mise run test

# Full: lint + unit + container images
mise run test:all

# Unit tests only
mise run test:unit          # in container (recommended)
mise run test:unit:local    # on host (may skip tests)

# Single container target
mise run test:image:zirconium
mise run test:image:bluefin

# Or via env var
TEST_TARGET=bluefin bats tests/image/

# Direct podman run
podman run --rm -v .:/dotfiles:ro dotfiles-test
```

### Test Container (`tests/Containerfile`)

The unit test runner image is based on Fedora 44 and includes all tools needed
for full test coverage: fish, neovim, lua, python3, git, systemd, shellcheck,
yamllint, chezmoi, bats, taplo, starship, and nushell. A seeded chezmoi config
provides template data (personal=true, headless=false, etc.) so template
rendering tests work without user interaction.

## VM Testing

VM tests provide the highest-fidelity validation — real systemd, real sudo,
real flatpak, real login shells. Currently manual.

### Prerequisites

- libvirt + qemu with KVM
- Zirconium qcow2 disk image (built via bootc-image-builder)
- SSH key access to VM

### Chezmoi Config Pre-seeding

**Important:** When applying dotfiles via SSH (non-TTY), chezmoi's
`.chezmoi.yaml.tmpl` auto-detects `stdinIsATTY=false` and defaults to
`ephemeral=true, headless=true`. This skips flatpaks, tailscale, fonts,
OrcaSlicer, and other GUI-dependent installs.

For automated tests against headful targets, **split init and apply** with a
config fix in between. `chezmoi init` always regenerates the config from the
template (ignoring pre-seeded values when `stdinIsATTY` is false):

```bash
# Step 1: Clone the repo (this generates wrong config: ephemeral=true, headless=true)
chezmoi init rwaltr --no-tty

# Step 2: Overwrite config with correct values for this target
cat > ~/.config/chezmoi/chezmoi.yaml << 'EOF'
# vi: ft=yaml

sourceDir: "/home/rwaltr/.local/share/chezmoi/home/home"

data:
  email: "rwaltr@rwalt.pro"
  personal: true
  work: false
  headless: false
  ephemeral: false
  osid: "linux-zirconium"
EOF

# Step 3: Apply with the corrected config
chezmoi apply --no-tty
```

> **Note:** `chezmoi init` sets `sourceDir` to `.../home/home` because the repo
> has `.chezmoiroot` pointing to `home/`, and chezmoi clones into
> `~/.local/share/chezmoi/home`. The sourceDir must reflect this double path.

#### Config Profiles for Different Targets

| Target | personal | headless | ephemeral | What runs |
|--------|----------|----------|-----------|-----------|
| Desktop (Zirconium) | true | false | false | Everything: brew, flatpaks, fonts, tailscale, orcaslicer |
| Desktop (work) | false | false | false | Brew + fonts, no personal flatpaks/orcaslicer |
| Headless server | false | true | false | Brew CLI tools only, no fonts/flatpaks |
| Container/CI | false | true | true | Minimal: files only, skip brew install |

#### Why Init + Fix + Apply (Not Pre-seed)

The `.chezmoi.yaml.tmpl` uses `stdinIsATTY` to decide whether to prompt:

```go-template
{{- if not $ephemeral -}}
{{-   if stdinIsATTY -}}
{{-     $headless  = promptBoolOnce . "headless"  "Headless?" -}}
{{-     ...
{{-   else -}}
{{-     $ephemeral = true -}}  ← SSH/automation falls here
{{-     $headless  = true -}}
{{-   end -}}
{{- end -}}
```

**Pre-seeding does NOT work** because `chezmoi init` regenerates the config
from the template, overwriting any pre-existing `chezmoi.yaml`. The non-TTY
else branch sets `ephemeral=true, headless=true` regardless of what was in
the config before. `promptBoolOnce` is never reached.

The fix: run `chezmoi init` first (let it generate wrong config), then
overwrite the config, then `chezmoi apply`.

### Known VM Issues

- **First-boot setup prompt**: Zirconium's `systemd-firstboot` blocks on the
  console for locale/timezone. Must be completed manually before SSH is
  available. BIB config with `locale`/`timezone` does not bypass this.
- **Flatpak system install**: Requires polkit session (graphical login).
  Fails when run via SSH with `Flatpak system operation Deploy not allowed
  for user`. Works fine on actual desktop session. The flatpak script
  (`always_after_35_flatpaks.sh`) will abort chezmoi apply on failure.
- **Yazi plugins**: `ya` CLI requires brew+mise PATH which isn't available in
  chezmoi script execution environment. Plugins install correctly when run
  from an interactive shell after apply.
- **tput warnings**: Starship prompt outputs `tput: No value for $TERM`
  in non-interactive SSH. Cosmetic only — set `TERM=dumb` to suppress.

## Tools

| Tool | Role | Installed via |
|---|---|---|
| [bats-core](https://github.com/bats-core/bats-core) | Test runner (bash) | `mise` |
| [goss](https://github.com/goss-org/goss) | In-container validation (YAML) | `mise` |
| [podman](https://podman.io/) | Container runtime (rootless) | System package |
| [libvirt](https://libvirt.org/) | VM management (Layer 3) | System package |

## Directory Structure

```
tests/
├── Containerfile                  # test runner image (Fedora 44 + all tools)
├── unit/                          # bats unit tests (Layer 1)
│   ├── atuin.bats
│   ├── bash.bats
│   ├── chezmoi.bats
│   ├── configs.bats
│   ├── fish.bats
│   ├── interactive.bats
│   ├── neovim.bats
│   ├── niri.bats
│   ├── nushell.bats
│   ├── scripts.bats
│   ├── security.bats
│   ├── starship.bats
│   ├── systemd.bats
│   ├── television.bats
│   ├── templates.bats
│   ├── tools.bats
│   ├── wezterm.bats
│   └── yazi.bats
├── image/                         # container image tests (Layer 2)
│   ├── run.bats                   # test orchestrator
│   ├── apply.sh                   # bootstrap script run inside containers
│   └── goss/                      # goss validation specs
│       ├── common.yaml
│       ├── bootc-zirconium.yaml
│       ├── bluefin.yaml
│       └── scripts.yaml
├── helpers/
│   ├── test_helper.bash           # shared bats helpers
│   └── image_helper.bash          # podman/goss helpers
└── README.md
```

## Adding a New OS Target

1. Add image to `get_image()` in `tests/helpers/image_helper.bash`
2. Create `tests/image/goss/<target>.yaml` (post-apply assertions)
3. Add test blocks in `tests/image/run.bats`
4. Optionally add a `mise run test:image:<target>` task in `mise.toml`
