---
name: niri
description: Niri Wayland compositor control via IPC - window management, workspace operations, output configuration, and compositor automation
---

# Niri Compositor Control

Use this skill when working with Niri compositor operations, window management, or workspace automation.

## Activation Triggers

Activate this skill **ONLY** when the user explicitly mentions:

- Niri compositor operations
- Generic Window positioning or management
- Workspace control and organization
- Output/monitor configuration changes
- Niri IPC automation
- Compositor state queries
- You are running on Linux,
- Niri is installed and active

**Do NOT activate automatically** - this is an on-demand skill that requires explicit user request.

## Capabilities

This skill provides:

- Window management (focus, move, resize, float/tile)
- Workspace operations (create, name, navigate, organize)
- Output configuration (resolution, scale, position, VRR)
- Column-based layout control (Niri's scrollable tiling)
- Real-time compositor state queries
- IPC automation and scripting
- Event stream monitoring

## Available Tools

- **niri msg**: Primary IPC interface for compositor control
- **distrobox-host-exec**: Required wrapper to reach host compositor from containers
- **JSON output**: All commands support `--json` flag for scripting

## Context Awareness

### Environment Detection

- Running in distrobox container - use `distrobox-host-exec niri msg`
- Niri version 25.11+ with full IPC support
- KDL configuration format
- DMS (DankMaterialShell) integration present

## Core Concepts

### Niri's Layout Model

**Scrollable Tiling**: Unlike i3/sway, Niri uses horizontal scrolling columns:

- Windows are organized in **columns**
- Columns can contain multiple windows (stacked/tabbed)
- Scroll horizontally through columns
- Each workspace has independent columns
- Column index starts at 1 (not 0)

**Key Differences from Traditional Tilers**:

- Not binary split (no automatic right/left split)
- Navigate by scrolling, not by directional splits
- Columns can be repositioned by index
- Multiple windows per column form a vertical stack

### Window States

- **Tiled**: Default state, in scrollable column layout
- **Floating**: Positioned absolutely, outside column flow
- **Fullscreen**: Takes entire output
- **Maximized**: Column fills available width

### Workspace Model

- Multiple workspaces per output/monitor
- Workspaces can be named (optional)
- Reference by number (1, 2, 3...) or name
- Each workspace has independent column layout
- Empty workspaces will auto remove in a few seconds

## Common Operations

### Query Compositor State

```bash
# List all windows with details
distrobox-host-exec niri msg windows
distrobox-host-exec niri msg --json windows

# List outputs (monitors)
distrobox-host-exec niri msg outputs

# List workspaces
distrobox-host-exec niri msg workspaces

# Get focused window
distrobox-host-exec niri msg focused-window

# Get focused output
distrobox-host-exec niri msg focused-output

# Check overview state
distrobox-host-exec niri msg overview-state
```

### Window Management

```bash
# Focus window by ID
distrobox-host-exec niri msg action focus-window --id <WINDOW_ID>

# Move window to different workspace
distrobox-host-exec niri msg action move-window-to-workspace --window-id <ID> --focus false <WORKSPACE_NUM>

# Toggle floating
distrobox-host-exec niri msg action toggle-window-floating --id <ID>
distrobox-host-exec niri msg action move-window-to-floating --id <ID>
distrobox-host-exec niri msg action move-window-to-tiling --id <ID>

# Resize window
distrobox-host-exec niri msg action set-window-width --id <ID> "50%"
distrobox-host-exec niri msg action set-window-height --id <ID> "30%"

# Close window
distrobox-host-exec niri msg action close-window --id <ID>

# Fullscreen
distrobox-host-exec niri msg action fullscreen-window --id <ID>
```

### Column Control (Niri-Specific)

```bash
# Move column to specific horizontal position
distrobox-host-exec niri msg action focus-window --id <WINDOW_ID>
distrobox-host-exec niri msg action move-column-to-index <COLUMN_INDEX>

# Column index starts at 1 (leftmost)
# Higher numbers = further right

# Move column left/right
distrobox-host-exec niri msg action move-column-left
distrobox-host-exec niri msg action move-column-right

# Center column on screen
distrobox-host-exec niri msg action center-column

# Maximize column width
distrobox-host-exec niri msg action maximize-column
```

### Workspace Operations

```bash
# Focus workspace by number
distrobox-host-exec niri msg action focus-workspace 1

# Focus workspace by name
distrobox-host-exec niri msg action focus-workspace "development"

# Name current workspace
distrobox-host-exec niri msg action set-workspace-name "myproject"

# Name specific workspace
distrobox-host-exec niri msg action set-workspace-name --workspace 2 "email"

# Unset workspace name (back to number only)
distrobox-host-exec niri msg action unset-workspace-name
distrobox-host-exec niri msg action unset-workspace-name 2
```

### Floating Window Positioning

```bash
# Float a window first
distrobox-host-exec niri msg action move-window-to-floating --id <ID>

# Move to specific position
distrobox-host-exec niri msg action move-floating-window --id <ID> --x 0 --y 1000

# Position is absolute in logical pixels
# For bottom-left: x=0, y=(screen_height - window_height - margin)
```

### Output Configuration (Temporary)

```bash
# Change resolution/refresh rate
distrobox-host-exec niri msg output "DP-1" mode 3440 1440 159.962

# Change scale
distrobox-host-exec niri msg output "DP-1" scale 1.5

# Reposition output
distrobox-host-exec niri msg output "DP-2" position 3440 200

# Enable VRR
distrobox-host-exec niri msg output "DP-1" vrr on

# Turn output off/on
distrobox-host-exec niri msg output "DP-2" off
distrobox-host-exec niri msg output "DP-2" on
```

### Interactive Tools

```bash
# Pick window with mouse
distrobox-host-exec niri msg pick-window

# Pick color from screen
distrobox-host-exec niri msg pick-color
```

## Workflow Patterns

### Organize Windows by App Type

```bash
# Get all windows
windows=$(distrobox-host-exec niri msg --json windows)

# Sort by app_id and move to organized columns
# 1. Get Firefox windows
# 2. Get terminal windows
# 3. Get communication apps (Discord, Slack)
# 4. Move each group to sequential column positions

# Example:
# Column 1: Terminals
# Column 2: Communication
# Columns 3+: Browsers
```

### Move All Windows to New Workspace

```bash
# Get all window IDs from workspace N
window_ids=$(distrobox-host-exec niri msg --json windows | \
  grep -o '"id":[0-9]*.*"workspace_id":N' | \
  grep -o '^"id":[0-9]*' | cut -d: -f2)

# Move each to target workspace without following
for id in $window_ids; do
  distrobox-host-exec niri msg action move-window-to-workspace \
    --window-id $id --focus false <TARGET_WORKSPACE>
done
```

### Create Monitoring Workspace

```bash
# Move to new workspace
distrobox-host-exec niri msg action focus-workspace 5

# Name it
distrobox-host-exec niri msg action set-workspace-name "monitoring"

# Spawn monitoring windows
distrobox-host-exec niri msg action spawn -- alacritty -e btop
distrobox-host-exec niri msg action spawn -- alacritty -e htop
distrobox-host-exec niri msg action spawn -- alacritty -e top
```

### Float and Corner Position

```bash
# Get window ID
WINDOW_ID=<id>

# Float it
distrobox-host-exec niri msg action move-window-to-floating --id $WINDOW_ID

# Resize to corner-appropriate size
distrobox-host-exec niri msg action set-window-width --id $WINDOW_ID "25%"
distrobox-host-exec niri msg action set-window-height --id $WINDOW_ID "30%"

# Position in bottom-left corner (for 1440p display)
distrobox-host-exec niri msg action move-floating-window --id $WINDOW_ID --x 0 --y 1000
```

## Best Practices

### Always Use distrobox-host-exec

Since you're running in a container, always wrap niri msg:

```bash
distrobox-host-exec niri msg <command>
```

### Get Window IDs First

Before operating on windows, get their IDs:

```bash
# Human-readable
distrobox-host-exec niri msg windows | grep "Window ID"

# For scripting
distrobox-host-exec niri msg --json windows | grep -o '"id":[0-9]*'
```

### Use --focus Flag Appropriately

When moving windows:

- `--focus true` (default): Follow window to new workspace
- `--focus false`: Keep focus on current workspace

```bash
# Move but stay on current workspace
distrobox-host-exec niri msg action move-window-to-workspace \
  --window-id 308 --focus false 2
```

### Reference Workspaces Consistently

- Use **numbers** for unnamed workspaces: `1`, `2`, `3`
- Use **names** for named workspaces: `"development"`, `"monitoring"`
- Don't mix - if workspace has name, use the name

### Understand Column Indexing

- Column index starts at **1** (not 0)
- Higher index = further right in layout
- Moving to index beyond current columns appends to end
- Columns re-index automatically when one is removed

### Validate Configuration

Before making config changes:

```bash
distrobox-host-exec niri validate
```

### Monitor Events

For automation, use event stream:

```bash
distrobox-host-exec niri msg event-stream
# Outputs real-time events (window open/close, focus changes, etc.)
```

## Integration with Other Skills

### With Containers Skill

Spawn containerized apps in specific workspaces:

```bash
# Switch to workspace
distrobox-host-exec niri msg action focus-workspace "containers"

# Spawn container with GUI
distrobox-host-exec niri msg action spawn -- \
  distrobox enter dev -- firefox
```

### With DMS Integration

Many operations go through DMS IPC:

```bash
# DMS shortcuts
dms ipc call spotlight toggle
dms ipc call clipboard toggle

# Direct niri equivalent
distrobox-host-exec niri msg action spawn -- <command>
```

## Limitations and Notes

### Workspace Deletion

- **Cannot delete workspaces** - No IPC command exists, a workspace must be empty and unnamed to be cleaned up
- Can only unset names or ignore them

### Configuration Changes

- Output changes via IPC are **temporary**
- Reset on config reload or compositor restart
- For permanent changes, edit `~/.config/niri/config.kdl` with chezmoi

### Window Identification

- Window IDs change across sessions
- Don't hardcode IDs - always query first
- Use app_id and title for matching if needed

### Column Behavior

- Columns auto-collapse when last window removed
- Column indices shift when column removed
- Can't pre-create empty columns

### JSON Parsing

- If you are missing `jq`, run it via `mise exec`

## Troubleshooting

### Commands Not Working

Check compositor version:

```bash
distrobox-host-exec niri msg version
# Should be 25.11+
```

### Window Not Moving

Verify window exists and get correct ID:

```bash
distrobox-host-exec niri msg windows | grep -A 5 "Window ID: <id>"
```

### Workspace Issues

List all workspaces to see current state:

```bash
distrobox-host-exec niri msg workspaces
```

### Output Configuration Not Applying

Remember changes are temporary:

```bash
# Won't persist across restarts
distrobox-host-exec niri msg output "DP-1" mode 3440 1440 159.962
```

## Related Documentation

- Niri Wiki: <https://github.com/YaLTeR/niri/wiki>
- DMS integration: `dms --help`
- Config validation: `distrobox-host-exec niri validate`

## Quick Reference

### Most Common Commands

```bash
# Query
distrobox-host-exec niri msg windows
distrobox-host-exec niri msg workspaces
distrobox-host-exec niri msg outputs

# Focus
distrobox-host-exec niri msg action focus-window --id <ID>
distrobox-host-exec niri msg action focus-workspace <NUM>

# Move
distrobox-host-exec niri msg action move-window-to-workspace --window-id <ID> <WORKSPACE>
distrobox-host-exec niri msg action move-column-to-index <INDEX>

# Float
distrobox-host-exec niri msg action toggle-window-floating --id <ID>

# Resize
distrobox-host-exec niri msg action set-window-width --id <ID> "50%"

# Spawn
distrobox-host-exec niri msg action spawn -- <command>
```

### Example: Complete Window Organization

```bash
# 1. Query current state
distrobox-host-exec niri msg windows > /tmp/windows.txt

# 2. Identify windows by app
TERMINAL_IDS=$(grep -B2 "Alacritty" /tmp/windows.txt | grep "Window ID" | awk '{print $3}' | tr -d ':')
FIREFOX_IDS=$(grep -B2 "firefox" /tmp/windows.txt | grep "Window ID" | awk '{print $3}' | tr -d ':')

# 3. Move to workspace 1
for id in $TERMINAL_IDS $FIREFOX_IDS; do
  distrobox-host-exec niri msg action move-window-to-workspace --window-id $id --focus false 1
done

# 4. Organize columns (focus each, move to position)
col=1
for id in $TERMINAL_IDS; do
  distrobox-host-exec niri msg action focus-window --id $id
  distrobox-host-exec niri msg action move-column-to-index $col
  ((col++))
done

# 5. Name workspace
distrobox-host-exec niri msg action focus-workspace 1
distrobox-host-exec niri msg action set-workspace-name "organized"
```

## Skill Activation Reminder

**This skill should ONLY be activated when explicitly requested by the user.**

Do not automatically use this skill for general window management discussions. Wait for specific mentions of:

- "use niri msg"
- "control niri"
- "organize my windows"
- "move windows via IPC"
- Other explicit niri compositor operations

This prevents unnecessary invocation and keeps the skill focused on actual compositor automation tasks.
