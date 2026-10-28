---
name: chezmoi-workflow
description: Chezmoi and repo workflow for the rwaltr dotfiles: daily chezmoi commands, adding/templating files, the mise test and lint suite, and the hk git hooks. Use when changing dotfiles, running checks before committing, or bootstrapping the environment.
---

# Chezmoi and repo workflow

Source root is `home/` (set by `.chezmoiroot`). All commands run from the repo root unless noted.

## Daily chezmoi usage

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

## Adding new files

```bash
# Add a file to chezmoi management
chezmoi add ~/.config/newfile

# Add a template
chezmoi add --template ~/.config/templated-file
```

File naming: `dot_` → `.`, `private_` → restrictive perms, `executable_` → executable,
`symlink_` → symlink, `.tmpl` → Go template.

## Testing changes

```bash
# Preview changes
chezmoi diff
chezmoi apply --dry-run --verbose

# Build test container (one-time)
mise run test:build

# Run unit tests in container
mise run test:unit

# Run unit tests locally (may skip if tools missing)
mise run test:unit:local

# Lint + unit tests
mise run test

# Full suite including container image tests
mise run test:all
```

## Lint and format

```bash
mise run lint        # all linters
mise run format      # all formatters
mise run check       # format + lint

# Individual
mise run lint:shell   # shellcheck
mise run lint:fish    # fish syntax
mise run lint:lua     # stylua check
mise run lint:yaml    # yamllint
mise run lint:toml    # taplo
mise run lint:markdown
mise run format:shell # shfmt
mise run format:lua
mise run format:toml
```

## Git hooks (hk)

The repo uses `hk` (by the mise author), configured in `hk.pkl`.

```bash
mise run hk:install   # one-time: writes .git/hooks/pre-commit and pre-push
mise run hk:check     # check staged files (same as `mise run check`)
mise run hk:fix       # auto-fix staged files
mise exec -- hk run pre-commit   # run the hook manually
HK=0 git commit -m "skip hooks"  # bypass once

# Debug
cat ~/.local/state/hk/output.log
```

- pre-commit: staged files only, auto-fixes when possible, stashes unstaged changes, fails on unfixable issues.
- pre-push: runs checks without auto-fix, prevents push on issues.

## Bootstrap

```bash
# From GitHub
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply rwaltr

# Or local
./install.sh
```

## Secrets

Never commit secrets. Use 1Password CLI via `.tmpl` templates. SOPS is configured for
sensitive files.
