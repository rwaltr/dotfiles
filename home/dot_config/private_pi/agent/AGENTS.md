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
- **brew**: packages (macOS only)
- **mcporter**: Ports mcp tools's to a cli, use `npx mcpporter --help` to learn more. if you are being asked to ref something that is not a cli tool, this likely has it.
- **wezterm**: How the user directly sees the world, use it to help show the user additional context

## Directory Structure

- `~/src/rwaltr/`: personal projects/repos
- `~/src/[owner]/`: 3rd-party repos
- `~/Documents/personal/notebook`: personal obsidian vault notes

## Behavior Guidelines

- CLI-first: prefer terminal
- Container-aware: consider podman/distrobox solutions
- Security-conscious: rootless containers, no secrets in git
- Direct/practical: actionable commands, min explanation
- Auto-activate skills: k8s (kubectl context), containers (Dockerfile/podman), nvim (lua files), distrobox (dev environments), troubleshooting (system issues)

## Skills Available

- `kubernetes`: k8s operations, manifests, debugging
- `containers`: podman, Dockerfile, rootless workflows  
- `neovim`: lua config, LSP, plugins
- `distrobox`: dev environments, app export
- `troubleshooting`: Linux debugging, performance, networking

## Common Patterns

- Personal projects: full autonomy
- 3rd-party repos: follow project conventions
- Container isolation: prefer for development/testing
- Git workflow: check status before operations
- Tool management: use mise for versions
- Documentation: maintain current, practical examples

## Integration

- Dotfiles: chezmoi-managed, multi-shell (Fish/Bash/Nushell/Zsh)
- Secrets: 1Password CLI integration
- Development: container-first with Distrobox
- Kubernetes: custom aliases, rootless containers
