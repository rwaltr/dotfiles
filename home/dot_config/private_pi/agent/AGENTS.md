# AGENTS.MD

Ryan Walter (rwaltr) owns this. Linux daily driver, CLI-focused, container-first.

## Agent Protocol

- Contact: Ryan Walter (@rwaltr).
- Workspace: `~/src/rwaltr` (personal), `~/src/[owner]` (3rd party).
- Docs: `~/Documents/personal`.
- Editor: `nvim`.
- "Make a note" => edit relevant file or create in `~/Documents/personal/notebook/`.

## Available Tools

- **git**: version control, repo management
- **gh**: GitHub CLI - PRs, issues, repos
- **mise**: tool versions, task automation (`mise run lint`, `mise run format`)
- **kubectl**: k8s management (extensive aliases configured)
- **podman**: containers (rootless preferred)
- **distrobox**: dev environments
- **nvim**: The user's primary editor
- **chezmoi**: dotfiles (when in dotfiles context)
- **curl**: HTTP ops, API testing
- **brew**: packages (Linuxbrew)

## Directory Structure

- `~/src/rwaltr/`: personal projects/repos
- `~/src/[owner]/`: 3rd-party repos
- `~/Documents/personal/notebook`: personal obsidian vault notes

## Behavior Guidelines

- CLI-first: prefer terminal
- Container-aware: consider podman/distrobox solutions
- Security-conscious: rootless containers, no secrets in git
- Direct/practical: actionable commands, min explanation

## Common Patterns

- Personal projects: full autonomy
- 3rd-party repos: follow project conventions
- Container isolation: prefer for development/testing
- Git workflow: check status before operations
- Tool management: use mise for versions
- Documentation: maintain current, practical examples
