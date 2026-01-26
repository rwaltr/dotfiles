# Dotfiles Agent Context

## Project Overview

This is a personal dotfiles repository managed with [Chezmoi](https://www.chezmoi.io/). It provides cross-platform configuration management for Linux and macOS environments, with a focus on containerized development workflows.

**Repository URL**: Initialized with `chezmoi init rwaltr`

## Project Philosophy

- **Minimal input required**: `chezmoi init rwaltr` should work with minimal configuration
- **Container-first**: Designed for portable development environments
- **Multi-shell by purpose**: 
  - **Fish**: Primary interactive shell, focused on user-friendliness
  - **Bash**: Streamlined scripting-focused configuration
  - **Nushell**: Data processing and structured data workflows
  - **Zsh**: Minimal config as migration bridge, shares config with Bash via POSIX compatibility
- **No system-level automation**: Does not manage host NetworkManager, systemd services, etc.
- **Secrets via 1Password**: Personal secrets managed through 1Password CLI
- **Not for servers**: Focused on workstation/development environments

## Target Environments

### Container Environments
- WofiOS/bluefin-cli containers
- Ad-hoc development containers
- Distrobox portable environments

### Operating Systems
- **Primary**: Fedora/Universal Blue (ublue)
- **Secondary**: macOS (minimal support)

### Desktop Environments
- Niri
- KDE

## Package Management Strategy

- **CLI tools**: mise (primary) / Homebrew (macOS)
- **GUI apps**: Flatpak (Linux)
- **Containers**: Podman
- **Portable environments**: Distrobox with exported applications

## Directory Structure

```
.
├── home/                           # Chezmoi source (set via .chezmoiroot)
│   ├── dot_bashrc                  # Main bash config
│   ├── dot_bash_profile
│   ├── dot_config/
│   │   ├── bashrc.d/              # Modular bash configuration
│   │   │   ├── 0.*.sh             # Core configs (prompt, editor, opts)
│   │   │   ├── aqua.sh
│   │   │   ├── carapace.sh
│   │   │   ├── kubectl.sh
│   │   │   └── rwaltr-aliases.sh
│   │   ├── containers/            # Container configs
│   │   ├── fish/                  # Fish shell config
│   │   ├── git/                   # Git configurations
│   │   │   ├── config.tmpl
│   │   │   └── personal
│   │   ├── kube/                  # Kubernetes configs
│   │   ├── mise/                  # Mise tool version manager
│   │   │   └── config.toml
│   │   ├── nushell/               # Nushell config
│   │   ├── nvim/                  # Neovim configuration
│   │   │   ├── init.lua
│   │   │   ├── lua/
│   │   │   └── stylua.toml
│   │   ├── opencode/              # OpenCode assistant configs
│   │   ├── private_atuin/         # Shell history (atuin)
│   │   ├── sops/                  # SOPS encryption config
│   │   ├── starship.toml          # Starship prompt config
│   │   ├── systemd/               # User systemd units
│   │   ├── wezterm/               # WezTerm terminal config
│   │   │   ├── colors/
│   │   │   ├── platforms/
│   │   │   └── wezterm.lua
│   │   └── zsh/                   # Zsh shell config
│   ├── dot_local/
│   │   └── bin/                   # User scripts
│   │       └── executable_ssh-multi.sh
│   ├── private_dot_ssh/           # SSH configuration
│   │   ├── keys.d/
│   │   ├── private_authorized_keys.tmpl
│   │   └── private_config.tmpl
│   ├── symlink_dot_bin.tmpl       # Symlinked bin directory
│   ├── symlink_dot_reminders
│   └── symlink_dot_zshrc
├── .chezmoiignore                 # Files to ignore (local configs)
├── .chezmoiroot                   # Points to 'home' directory
├── .chezmoiversion                # Chezmoi version: 2.62.7
├── .sops.yaml                     # SOPS configuration
├── install.sh                     # Bootstrap installation script
└── README.md                      # Project documentation
```

## Key Technologies & Tools

### Shell & CLI
- **Shells**: 
  - **Fish** (primary interactive) - User-friendly, modern syntax
  - **Bash** (scripting) - Streamlined, modular, POSIX-compatible scripting
  - **Nushell** (data processing) - Structured data manipulation
  - **Zsh** (migration bridge) - Minimal config, shares Bash configuration via POSIX compatibility
- **Prompt**: Starship (cross-shell)
- **History**: Atuin (cross-shell)
- **Completions**: Carapace
- **Aliases**: complete_alias.sh (Bash/Zsh via POSIX compatibility)

### Development Tools
- **Editor**: Neovim (Lua-based config)
- **Terminal**: WezTerm (multi-platform support)
- **Version Manager**: mise (for tool versions)
- **Kubernetes**: kubectl, krew, custom kubeconfig management
- **Git**: Template-based configuration

### Container & Cloud
- **Container Runtime**: Podman
- **Development Environments**: Distrobox
- **Kubernetes tooling**: kubectl with extensive aliases and completions

## Important Files

### Configuration Entry Points
- `home/dot_config/fish/config.fish` - Fish shell (primary interactive shell)
- `home/dot_bashrc` - Bash initialization (scripting-focused, sources bashrc.d/*.sh)
- `home/dot_config/zsh/` - Zsh (minimal, leverages Bash config via POSIX compatibility)
- `home/dot_config/nushell/` - Nushell (data processing workflows)
- `home/dot_config/starship.toml` - Cross-shell prompt configuration
- `home/dot_config/nvim/init.lua` - Neovim entry point
- `home/dot_config/wezterm/wezterm.lua` - Terminal configuration

### Chezmoi Metadata
- `.chezmoiroot` - Sets source directory to `home/`
- `.chezmoiignore` - Excludes `.config/wezterm/local.lua`
- `.sops.yaml` - Encryption configuration for secrets

### Bootstrap
- `install.sh` - Self-contained installer that:
  - Installs chezmoi if not present
  - Initializes from source directory
  - Applies configuration automatically

## Templating & Secrets

### Chezmoi Templates
Files with `.tmpl` extension are processed as Go templates:
- `home/dot_config/git/config.tmpl`
- `home/private_dot_ssh/private_authorized_keys.tmpl`
- `home/private_dot_ssh/private_config.tmpl`
- `home/symlink_dot_bin.tmpl`

### Secrets Management
- **Tool**: 1Password CLI
- **Scope**: Personal use only
- **Method**: Templates can reference 1Password items
- **Encryption**: SOPS configured for sensitive files

## Shell-Specific Configuration Philosophy

### Fish (Primary Interactive Shell)
Located in `home/dot_config/fish/` - focused on **user-friendliness**:
- Modern, intuitive syntax
- Excellent out-of-the-box experience
- Auto-suggestions and completions
- Primary shell for daily interactive use

### Bash (Scripting Shell)
Located in `home/dot_bashrc` and `home/dot_config/bashrc.d/` - focused on **streamlined scripting**:
- Modular configuration via `bashrc.d/*.sh`
- POSIX-compatible for portability
- Script execution and automation
- Shared with Zsh via POSIX compatibility

### Nushell (Data Processing)
Located in `home/dot_config/nushell/` - focused on **structured data workflows**:
- Pipeline-oriented data processing
- Structured data manipulation
- Modern approach to shell scripting with typed data

### Zsh (Migration Bridge)
Located in `home/dot_config/zsh/` - **minimal configuration**:
- Helps users transition to Fish/Nushell
- Leverages Bash configuration via POSIX compatibility
- Shares bashrc.d modules where applicable
- Not heavily customized

## Modular Bash Configuration

The `home/dot_config/bashrc.d/` directory contains modular bash scripts for scripting-focused configuration, loaded in alphabetical order.

**Note**: Zsh can source these same scripts due to POSIX compatibility, providing consistency between Bash and Zsh environments.

### Core (0.* prefix for load order)
- `0.complete_alias.sh` - Alias completion support
- `0.custom_prompt.sh` - Prompt customization
- `0.editor.sh` - Editor configuration
- `0.opts.sh` - Shell options

### Tool-specific
- `aqua.sh` - Aqua package manager
- `carapace.sh` - Completion generator
- `exa.sh` - Modern ls replacement
- `kubectl.sh` - Kubernetes CLI enhancements
- `kubeconfig.sh` - Kubeconfig management
- `krew.sh` - kubectl plugin manager
- `paths.sh` - PATH management
- `rwaltr-aliases.sh` - Personal aliases
- `thefuck.sh` - Command correction tool

## Common Operations

### Initial Setup
```bash
# Bootstrap from GitHub
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply rwaltr

# Or use local install.sh
./install.sh
```

### Daily Usage
```bash
# Update dotfiles from source
chezmoi update

# Edit a file in source state
chezmoi edit ~/.bashrc

# Apply changes
chezmoi apply

# See what would change
chezmoi diff
```

### Adding New Files
```bash
# Add a file to chezmoi management
chezmoi add ~/.config/newfile

# Add a template
chezmoi add --template ~/.config/templated-file
```

## Development Workflow

1. **Interactive Shell**: Fish provides user-friendly interactive experience
2. **Scripting**: Bash for scripts and automation tasks
3. **Data Processing**: Nushell for structured data manipulation
4. **Migration Support**: Zsh available as bridge, sharing Bash config
5. **Container Development**: Primary workflow uses Distrobox containers with dotfiles
6. **Editor**: Neovim with Lua configuration for modern development
7. **Terminal**: WezTerm provides consistent terminal experience across platforms

## Important Notes

### What This Manages
- ✅ User-level dotfiles and configurations
- ✅ Fish shell environment (primary interactive)
- ✅ Bash environment (streamlined scripting)
- ✅ Nushell environment (data processing)
- ✅ Zsh environment (minimal migration bridge, shares Bash config)
- ✅ Development tool configurations (git, nvim, etc.)
- ✅ SSH configuration
- ✅ Container and Kubernetes tooling

### What This Does NOT Manage
- ❌ Host system NetworkManager configuration
- ❌ Host-level systemd services
- ❌ Server infrastructure
- ❌ System packages (handled by distro/Flatpak/mise)

## Maintenance Guidelines

### When Modifying Configurations

1. **Fish Scripts**: Focus on user-friendliness and interactive features
2. **Bash Scripts**: Keep streamlined and scripting-focused; add to `bashrc.d/` for modularity
3. **Zsh Scripts**: Keep minimal; prefer sharing Bash config via POSIX compatibility
4. **Nushell Scripts**: Focus on data processing and structured workflows
5. **POSIX Compatibility**: Bash configs should work in Zsh where possible
6. **Templates**: Use `.tmpl` extension for files needing variable substitution
7. **Secrets**: Never commit secrets directly; use 1Password CLI templates
8. **Cross-platform**: Consider macOS compatibility when adding Linux-specific tools
9. **Containers**: Test in both host and containerized environments

### File Naming Conventions
- `dot_` prefix → becomes `.` (e.g., `dot_bashrc` → `.bashrc`)
- `private_` prefix → restricts permissions
- `executable_` prefix → makes file executable
- `symlink_` prefix → creates symbolic link
- `.tmpl` suffix → processes as template

## Testing Changes

Before committing:
```bash
# Preview changes
chezmoi diff

# Dry run
chezmoi apply --dry-run --verbose

# Test in isolated container
distrobox create --name test-dotfiles
distrobox enter test-dotfiles
chezmoi init --apply rwaltr
```

## Related Resources

- [Chezmoi Documentation](https://www.chezmoi.io/)
- [Starship Prompt](https://starship.rs/)
- [WezTerm](https://wezfurlong.org/wezterm/)
- [mise](https://mise.jdx.dev/)
- [Distrobox](https://github.com/89luca89/distrobox)

## Development Workflow with Mise Tasks

Mise tasks provide automated linting and formatting for the dotfiles repository.

### Available Tasks

#### Linting Tasks
```bash
# Lint all files (runs all linters)
mise run lint

# Individual linters
mise run lint:shell      # Lint bash scripts with shellcheck
mise run lint:fish       # Check fish syntax
mise run lint:lua        # Check Lua syntax with stylua
mise run lint:yaml       # Lint YAML files with yamllint
mise run lint:toml       # Check TOML files with taplo
mise run lint:markdown   # Lint markdown with markdownlint-cli2
```

#### Formatting Tasks
```bash
# Format all code
mise run format

# Individual formatters
mise run format:shell    # Format bash scripts with shfmt
mise run format:lua      # Format Lua files with stylua
mise run format:toml     # Format TOML files with taplo
```

#### Combined Tasks
```bash
# Run format and lint (full check)
mise run check

# Install git pre-commit hooks
mise run pre-commit-install
```

### Pre-commit Hook Workflow

For automated linting before commits:

1. **Install pre-commit hooks**: `mise run pre-commit-install`
2. **Manual check before commit**: `mise run lint`
3. **Auto-format code**: `mise run format`
4. **Full check**: `mise run check`

### Integration with Git

Add to your workflow:
```bash
# Before committing
mise run check

# If formatting is needed
mise run format

# Verify changes
mise run lint
```

### Task Configuration

All tasks are defined in `mise.toml` in the `[tasks]` section. Tasks support:
- Dependencies between tasks
- Parallel execution
- Environment variables
- File watching (sources/outputs)

## Git Hooks with hk

The project uses `hk` (by the mise author) for high-performance git hook management.

### What is hk?

`hk` is a modern git hook manager that:
- **Runs fast**: Parallel execution with file locking
- **Integrates with mise**: Automatic tool management
- **Auto-fixes**: Can automatically fix issues before commit
- **Smart staging**: Only lints/formats staged files
- **Stash handling**: Safely stashes unstaged changes

### Configuration

Git hooks are configured in `hk.pkl` (Pkl configuration language):

**Configured Linters:**
- `shellcheck` - Bash/shell script linting
- `shfmt` - Shell script formatting
- `fish` - Fish shell syntax checking
- `stylua` - Lua formatting (for Neovim configs)
- `yamllint` - YAML linting
- `taplo` - TOML formatting
- `markdownlint-cli2` - Markdown linting
- Git utilities (merge conflicts, trailing whitespace, newlines, etc.)

### Setup

```bash
# Install git hooks (one-time setup)
mise run hk:install

# This creates:
# - .git/hooks/pre-commit (runs on commit)
# - .git/hooks/pre-push (runs on push)
```

### Usage

```bash
# Check staged files (what pre-commit will run)
mise run hk:check
# or: mise run check

# Auto-fix issues in staged files
mise run hk:fix

# Manually run pre-commit hook
mise exec -- hk run pre-commit

# Skip hooks temporarily
HK=0 git commit -m "skip hooks"
```

### Hook Behavior

**Pre-commit Hook:**
- ✅ Runs automatically on `git commit`
- ✅ Only checks staged files
- ✅ Auto-fixes issues when possible
- ✅ Stashes unstaged changes before running
- ✅ Fails commit if unfixable issues found

**Pre-push Hook:**
- ✅ Runs automatically on `git push`
- ✅ Runs checks (no auto-fix)
- ✅ Prevents push if issues found

### Files Checked

The hooks intelligently filter files by type:
- **Shell scripts**: `home/dot_config/bashrc.d/*.sh`, `home/dot_local/bin/executable_*.sh`
- **Fish scripts**: `home/dot_config/fish/**/*.fish`
- **Lua files**: `home/dot_config/nvim/**/*.lua`
- **YAML files**: `*.yaml`, `*.yml`, `.sops.yaml`, `home/.chezmoiexternal.yaml`
- **TOML files**: `*.toml`, `home/dot_config/**/*.toml`
- **Markdown**: `*.md`

### Troubleshooting

```bash
# View full output log
cat ~/.local/state/hk/output.log

# Disable hooks for one commit
HK=0 git commit -m "emergency fix"

# Reinstall hooks
mise run hk:install

# Test hooks without committing
mise run hk:check
```

### Why hk over pre-commit?

- **Faster**: Parallel execution, no Python overhead
- **Mise integration**: Uses mise-managed tools automatically
- **Simpler**: One config file (`hk.pkl`)
- **Same author**: Tight integration with mise ecosystem
- **File locking**: Safe concurrent execution

