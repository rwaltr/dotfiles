---
name: wezterm
description: Use this skill to show the user stuff visually or to run seperate long running tasks
---
# WezTerm Interactive Display Skill

## Purpose

Use WezTerm to display context, code, diffs, or long-running tasks in a separate window. **Display only - ask questions in chat to avoid timeouts.**

## When to Use

- **Show context for review**: Display file contents, configuration sections, or logs while asking questions in chat
- **Display proposed changes**: Show diffs, edits, or modifications in WezTerm, then ask for approval in chat
- **Present error context**: Show errors or warnings in WezTerm for reference during troubleshooting discussion
- **Long-running tasks**: Monitor `gh run watch`, CI/CD pipelines, build processes in background panes
- **Parallel execution**: Run tasks in background panes while continuing main workflow
- **Continuous monitoring**: Tail logs, watch deployments, poll for status

## Core Principle: Separate Display from Interaction

**WezTerm = Display Context**  
**Chat = Ask Questions & Get Responses**

This prevents timeout issues and keeps the conversation flowing naturally.

## Core Pattern: Display Context (Non-Blocking)

Show context in WezTerm, then ask in chat:

```bash
# Display the context in WezTerm (non-blocking)
wezterm cli spawn -- bash -c "
clear
echo '═══════════════════════════════════════════════════════════════'
echo 'PROPOSED CHANGES: ~/.bashrc'
echo '═══════════════════════════════════════════════════════════════'
echo
echo 'Adding new aliases at lines 15-17'
echo
bat --style=numbers --line-range=10:25 ~/.bashrc
echo
echo '─────────────────────────────────────────────────────────────'
echo 'Review this window, then respond in chat'
echo
echo 'Window will close automatically when you confirm in chat'
"

# Then ask in chat (no blocking)
echo "I've opened a WezTerm window showing the proposed changes."
echo ""
echo "**Do you want me to proceed with these changes?** (yes/no)"
```

**User responds in chat** → Agent proceeds or cancels → Close WezTerm window if needed

## Display Components

### 1. WHY Section

Always explain in the WezTerm window what's being shown:

- What action you're planning to take
- What changes will be made
- What files are affected

### 2. CONTEXT Section

Show the relevant content using `bat`:

**Show specific lines:**

```bash
bat --style=numbers --line-range=10:20 /path/to/file
```

**Show entire file with line numbers:**

```bash
bat --style=numbers /path/to/file
```

**Show with syntax highlighting (auto-detected):**

```bash
bat --language=bash --style=numbers /path/to/file
```

**Show diff:**

```bash
diff -u old.txt new.txt | bat --language=diff
```

### 3. FOOTER

End with a note directing user to chat:

```bash
echo 'Review this window, then respond in chat'
```

### 4. ASK IN CHAT

After spawning the window, immediately ask the question in chat with clear formatting:

```
I've opened a WezTerm window showing [description].

**Question here?** (yes/no)
```

## Common Use Cases

### 1. Show Changes and Ask for Confirmation

```bash
# Show the changes in WezTerm
pane_id=$(wezterm cli spawn -- bash -c "
clear
echo '═══════════════════════════════════════════════════════════════'
echo 'PROPOSED EDIT: ~/.bashrc'
echo '═══════════════════════════════════════════════════════════════'
echo
echo 'Adding new aliases at lines 15-17:'
echo '  alias ll=\"ls -la\"'
echo '  alias gs=\"git status\"'
echo
echo '─────────────────────────────────────────────────────────────'
echo 'CURRENT FILE (lines 10-25):'
echo '─────────────────────────────────────────────────────────────'
echo
bat --style=numbers --line-range=10:25 ~/.bashrc
echo
echo '─────────────────────────────────────────────────────────────'
echo 'Review this window, then respond in chat'
")

echo "✓ Opened WezTerm pane: $pane_id"
```

Then in chat response:

```
I've opened a WezTerm window showing the current ~/.bashrc file (lines 10-25) and the aliases I plan to add.

**Do you want me to proceed with adding these aliases?** (yes/no)
```

User responds in chat → proceed or cancel → optionally close pane:

```bash
# If proceeding
wezterm cli kill-pane --pane-id $pane_id
```

### 2. Show Context for Discussion

```bash
# Display context (no blocking)
wezterm cli spawn -- bash -c "
clear
echo '═══════════════════════════════════════════════════════════════'
echo 'CONTEXT: Current kubectl configuration'
echo '═══════════════════════════════════════════════════════════════'
echo
bat --language=yaml ~/.kube/config
echo
echo '─────────────────────────────────────────────────────────────'
echo 'Reference for chat discussion'
"
```

Then in chat:

```
I've opened your kubectl config for reference. Which cluster would you like to switch to?
```

### 3. Show Diff Before Applying

```bash
# Generate and display diff
pane_id=$(wezterm cli spawn -- bash -c "
clear
echo '═══════════════════════════════════════════════════════════════'
echo 'DIFF: Proposed changes to config.toml'
echo '═══════════════════════════════════════════════════════════════'
echo
diff -u original.toml modified.toml | bat --language=diff
echo
echo '─────────────────────────────────────────────────────────────'
echo 'Review the diff, then respond in chat'
")
```

Then in chat:

```
I've opened a diff showing the proposed changes to config.toml.

**Should I apply these changes?** (yes/no)
```

### 4. Display Error Context

```bash
# Show error location
wezterm cli spawn -- bash -c "
clear
echo '═══════════════════════════════════════════════════════════════'
echo 'ERROR: Build failed at line 42'
echo '═══════════════════════════════════════════════════════════════'
echo
bat --style=numbers --line-range=35:50 --highlight-line=42 build.log
echo
echo '─────────────────────────────────────────────────────────────'
echo 'Error context - see chat for troubleshooting'
"
```

Then in chat:

```
I've highlighted the error location in WezTerm. The build fails because [explanation].

Would you like me to try [solution]?
```

### 5. Monitor Long-Running Task (Non-Blocking)

```bash
# Start monitoring in background
pane_id=$(wezterm cli spawn -- bash -c "
clear
echo '═══════════════════════════════════════════════════════════════'
echo 'MONITORING: GitHub Actions Workflow'
echo '═══════════════════════════════════════════════════════════════'
echo
gh run watch
echo
echo '─────────────────────────────────────────────────────────────'
echo 'Workflow completed! You can close this pane now.'
")

echo "✓ Started workflow monitoring in pane: $pane_id"
```

Then in chat:

```
I've started monitoring the GitHub Actions workflow in a WezTerm pane. 

I'll continue with other tasks while it runs. You can close the pane when you're done reviewing it.
```

### 6. Continuous Monitoring (Background Pane)

```bash
# Start log monitoring
pane_id=$(wezterm cli spawn -- bash -c "
clear
echo '═══════════════════════════════════════════════════════════════'
echo 'MONITORING: Kubernetes Pod Logs (Live)'
echo '═══════════════════════════════════════════════════════════════'
echo
kubectl logs -f deployment/myapp --tail=50
")

echo "✓ Started log monitoring in pane: $pane_id"
```

Then in chat:

```
I've started live log monitoring in a WezTerm pane. You can close it anytime or let me know when you want me to stop it.
```

### 7. Poll Until Condition Met (Background)

```bash
# Start polling in background
pane_id=$(wezterm cli spawn -- bash -c "
clear
echo '═══════════════════════════════════════════════════════════════'
echo 'WAITING: Until pods are ready'
echo '═══════════════════════════════════════════════════════════════'
echo
echo 'Polling every 5 seconds...'
echo

until kubectl get pods -l app=myapp | grep -q '1/1.*Running'; do
  echo \"\$(date '+%H:%M:%S') - Waiting for pods to be ready...\"
  kubectl get pods -l app=myapp
  echo
  sleep 5
done

echo
echo '✓ Pods are ready! You can close this pane now.'
")

echo "✓ Started polling in pane: $pane_id"
```

Then in chat:

```
I've started polling for pod readiness in a WezTerm pane. I'll continue with other work and can check back on the status.

Would you like me to wait for completion or proceed with other tasks?
```

### 8. Multiple Parallel Tasks

```bash
# Start multiple monitoring panes
build_pane=$(wezterm cli spawn -- bash -c "
echo '═══════════════════════════════════════════════════════════════'
echo 'BUILD MONITOR'
echo '═══════════════════════════════════════════════════════════════'
mise run build --watch
")

test_pane=$(wezterm cli spawn -- bash -c "
echo '═══════════════════════════════════════════════════════════════'
echo 'TEST MONITOR'
echo '═══════════════════════════════════════════════════════════════'
mise run test --watch
")

log_pane=$(wezterm cli spawn -- bash -c "
echo '═══════════════════════════════════════════════════════════════'
echo 'LOG MONITOR'
echo '═══════════════════════════════════════════════════════════════'
tail -f app.log
")

echo "✓ Started parallel monitoring:"
echo "  Build: pane $build_pane"
echo "  Tests: pane $test_pane"
echo "  Logs:  pane $log_pane"
```

Then in chat:

```
I've started monitoring three things in parallel:
- Build process (pane $build_pane)
- Test suite (pane $test_pane)  
- Application logs (pane $log_pane)

All are running in background. What would you like me to work on next?
```

### 9. Highlight Specific Code Section

```bash
# Show specific function or section
pane_id=$(wezterm cli spawn -- bash -c "
clear
echo '═══════════════════════════════════════════════════════════════'
echo 'CODE REVIEW: init_kubernetes() function'
echo '═══════════════════════════════════════════════════════════════'
echo
echo 'Found potential issue at line 156'
echo
bat --style=numbers --line-range=145:170 --highlight-line=156 script.sh
echo
echo '─────────────────────────────────────────────────────────────'
echo 'See chat for discussion'
")
```

Then in chat:

```
I've highlighted line 156 in WezTerm where there's a potential issue with the kubectl command.

The problem is [explanation]. Should I fix it by [proposed solution]?
```

## Best Practices

1. **Always use `bat` for file display** - Provides syntax highlighting and line numbers
2. **Display in WezTerm, ask in chat** - Prevents timeout issues with blocking input
3. **Save pane IDs** - Allows closing panes later or checking status
4. **Add clear headers** - Always show what's being displayed and why
5. **Direct to chat** - End display with "Review this window, then respond in chat"
6. **Use bold for questions in chat** - Makes questions clear: `**Question?**`
7. **Provide context in chat** - Summarize what's in the WezTerm window
8. **Close panes when done** - Clean up with `wezterm cli kill-pane --pane-id $pane_id`
9. **Never use `sleep` for display windows** - Blocks user interaction, let user close manually
10. **Let tasks auto-close naturally** - When task completes, pane exits on its own
11. **Show line ranges** - Use `--line-range` to focus on relevant sections

## bat Options Reference

```bash
# Line numbers only
bat --style=numbers

# Specific line range
bat --line-range=10:20

# Highlight specific lines
bat --highlight-line=15

# Force language detection
bat --language=bash

# Plain output (no decorations)
bat --style=plain

# Show non-printable characters
bat --show-all

# Paging (for long files)
bat --paging=always
```

## Integration with Other Skills

### With Kubernetes Skill

Show manifest before applying:

```bash
kubectl get pod mypod -o yaml | bat --language=yaml
```

### With Containers Skill

Show Containerfile before building:

```bash
bat --language=dockerfile Containerfile
```

### With Neovim Skill

Show nvim config section before editing:

```bash
bat --language=lua --line-range=50:75 ~/.config/nvim/init.lua
```

## Workspaces and Organization

WezTerm supports **workspaces** for organizing panes and windows into logical groups. This is useful for separating different projects or contexts.

### Understanding Workspaces

- **Workspace**: A named collection of windows and panes
- **Default workspace**: "default" (used when no workspace specified)
- **Isolated**: Each workspace is independent
- **Persistent**: Workspaces remain until all panes are closed

### Workspace Commands

**Create pane in new workspace:**

```bash
# Spawn in a new workspace
pane_id=$(wezterm cli spawn --new-window --workspace "project-name" -- bash -c "
echo 'Working in workspace: project-name'
command
")
```

**List all workspaces:**

```bash
# Show all workspaces with their panes
wezterm cli list --format json | jq -r '.[] | .workspace' | sort -u

# Or in table format
wezterm cli list | awk '{print $4}' | sort -u
```

**Rename workspace:**

```bash
# Rename current workspace
wezterm cli rename-workspace "new-name"

# Rename specific workspace
wezterm cli rename-workspace --workspace "old-name" "new-name"
```

**Check current workspace:**

```bash
# Get workspace of current pane
wezterm cli list --format json | jq -r '.[] | select(.is_active) | .workspace'
```

### Use Cases for Workspaces

#### 1. Organize by Project

```bash
# Create workspace for project monitoring
project_pane=$(wezterm cli spawn --new-window --workspace "myapp-dev" -- bash -c "
clear
echo '═══════════════════════════════════════════════════════════════'
echo 'PROJECT: myapp - Development Environment'
echo '═══════════════════════════════════════════════════════════════'
echo
cd ~/src/myapp
bash
")

# Add build monitoring to same workspace
build_pane=$(wezterm cli spawn --workspace "myapp-dev" -- bash -c "
cd ~/src/myapp
mise run build --watch
")

# Add test monitoring to same workspace
test_pane=$(wezterm cli spawn --workspace "myapp-dev" -- bash -c "
cd ~/src/myapp
mise run test --watch
")

echo "✓ Created myapp-dev workspace with build and test monitoring"
```

#### 2. Separate Contexts

```bash
# Development workspace
wezterm cli spawn --new-window --workspace "development" -- bash

# Monitoring workspace
wezterm cli spawn --new-window --workspace "monitoring" -- bash -c "
kubectl get pods -A -w
"

# Troubleshooting workspace
wezterm cli spawn --new-window --workspace "debug" -- bash
```

#### 3. Temporary vs Persistent

```bash
# Temporary workspace for one-off task
wezterm cli spawn --new-window --workspace "temp-analysis" -- bash -c "
analyze-logs.sh
# Workspace will disappear when pane closes
"

# Persistent workspace for ongoing work
wezterm cli spawn --new-window --workspace "main-project" -- bash
# Keep this workspace around for the session
```

#### 4. Show Context in Dedicated Workspace

```bash
# Create a workspace just for showing context to user
show_workspace="review-$(date +%s)"

pane_id=$(wezterm cli spawn --new-window --workspace "$show_workspace" -- bash -c "
clear
echo '═══════════════════════════════════════════════════════════════'
echo 'CODE REVIEW: Proposed Changes'
echo '═══════════════════════════════════════════════════════════════'
echo
echo 'Workspace: $show_workspace'
echo
bat --style=numbers --diff <(cat old.txt) <(cat new.txt)
echo
echo '─────────────────────────────────────────────────────────────'
echo 'Review this workspace, then respond in chat'
")

echo "✓ Created dedicated review workspace: $show_workspace"
```

### Workspace Management Pattern

```bash
# Function to organize task by workspace
organize_task() {
    local workspace_name="$1"
    local task_name="$2"
    local command="$3"
    
    # Check if workspace exists
    existing=$(wezterm cli list --format json | jq -r ".[] | select(.workspace == \"$workspace_name\") | .workspace" | head -1)
    
    if [[ -n "$existing" ]]; then
        # Add to existing workspace
        pane_id=$(wezterm cli spawn --workspace "$workspace_name" -- bash -c "$command")
        echo "✓ Added $task_name to existing workspace: $workspace_name (pane: $pane_id)"
    else
        # Create new workspace
        pane_id=$(wezterm cli spawn --new-window --workspace "$workspace_name" -- bash -c "$command")
        echo "✓ Created new workspace: $workspace_name with $task_name (pane: $pane_id)"
    fi
}

# Usage
organize_task "k8s-ops" "pod-watch" "kubectl get pods -A -w"
organize_task "k8s-ops" "logs" "kubectl logs -f deployment/myapp"
```

### Domain Support

WezTerm supports **domains** for connecting to remote systems or multiplexers:

- **Local domain**: Default, runs on your machine
- **SSH domain**: Connect to remote systems via SSH
- **Unix domain**: Connect to local Unix domain sockets
- **WSL domain**: Connect to Windows Subsystem for Linux

**Specify domain when spawning:**

```bash
# Spawn in specific domain (if configured)
wezterm cli spawn --domain-name "remote-server" -- command
```

**Note**: Domains require configuration in WezTerm config file and are typically used for persistent remote connections, not for our display use cases.

### Best Practices for Workspaces

1. **Use descriptive names** - "myapp-dev" not "workspace1"
2. **Organize by context** - project, environment, task type
3. **Temporary workspaces** - Use timestamps for unique review workspaces
4. **Clean up** - Close panes to remove workspace when done
5. **List before creating** - Check existing workspaces to avoid duplicates
6. **Consistent naming** - Use conventions like "project-type" or "env-task"

### Workspace Patterns for Display

**Pattern 1: Dedicated Review Workspace**

```bash
review_ws="review-config-$(date +%s)"
wezterm cli spawn --new-window --workspace "$review_ws" -- bash -c "
bat --style=numbers config.yaml
echo 'Review complete, close pane to remove workspace'
"
```

**Pattern 2: Persistent Project Workspace**

```bash
if ! wezterm cli list --format json | jq -e ".[] | select(.workspace == \"$PROJECT_NAME\")" &>/dev/null; then
    wezterm cli spawn --new-window --workspace "$PROJECT_NAME" -- bash
fi
# Add monitoring to project workspace
wezterm cli spawn --workspace "$PROJECT_NAME" -- watch kubectl get pods
```

**Pattern 3: Group Related Tasks**

```bash
task_ws="ci-pipeline"
wezterm cli spawn --new-window --workspace "$task_ws" -- gh run watch
wezterm cli spawn --workspace "$task_ws" -- kubectl logs -f job/build
wezterm cli spawn --workspace "$task_ws" -- tail -f deployment.log
```

## Technical Notes

- **`wezterm cli spawn`** - Creates new pane and returns immediately (NON-BLOCKING)
  - Use for: display context, background tasks, monitoring
  - Agent continues immediately, pane stays open
  - Returns pane ID for later management
- **Avoid `wezterm start --always-new-process`** - BLOCKS execution until window closes
  - ❌ Don't use for confirmations (causes timeout)
  - ⚠️ Only use if you truly need to block (rare)
- **Pane management**:
  - List panes: `wezterm cli list`
  - Kill pane: `wezterm cli kill-pane --pane-id <id>`
  - Check if running: `wezterm cli list | grep -q "^$pane_id"`
- **Workspaces**:
  - Organize panes by project/context
  - Create: `--new-window --workspace "name"`
  - Add to existing: `--workspace "name"`
  - List: `wezterm cli list` shows workspace column
  - Rename: `wezterm cli rename-workspace "new-name"`
  - Default workspace: "default"
- **Domains**:
  - Specify with `--domain-name` (requires config)
  - Mainly for SSH/remote connections
  - Not typically needed for display use cases
- **Chat interaction** - User responds in chat, not in WezTerm
- **Escaping** - Variables in the inner bash need `\$` to avoid early expansion
- **Never use `sleep` for display windows** - Blocks user from interacting with terminal
- **Task auto-close** - Tasks naturally exit when complete (e.g., `gh run watch` finishes)

## Workflow Pattern

### Display + Chat Interaction Pattern (Recommended)

1. **Display context in WezTerm** - Use `wezterm cli spawn` (non-blocking)
2. **Save pane ID** - For later management if needed
3. **Summarize in chat** - Explain what's shown in WezTerm
4. **Ask question in chat** - Use bold formatting for clarity
5. **Wait for response** - User responds in chat thread
6. **Proceed based on response** - Execute or cancel action
7. **Clean up** - Close pane if appropriate

### Example Flow

```bash
# 1. Display in WezTerm
pane_id=$(wezterm cli spawn -- bash -c "
clear
echo 'PROPOSED CHANGES: config.yaml'
echo '─────────────────────────────────────────────────────────────'
bat --style=numbers config.yaml
echo
echo 'Review this, then respond in chat'
")

# 2. Save pane ID (stored in variable)

# 3-4. Summarize and ask in chat (in your response to user)
```

**Then in chat:**

```
I've opened config.yaml in WezTerm showing the current configuration.

**Do you want me to add the new database settings?** (yes/no)
```

**User responds "yes" in chat** → You proceed:

```bash
# 6. Proceed with changes
# 7. Close the display pane
wezterm cli kill-pane --pane-id $pane_id
```

### Long-Running Task Pattern

1. **Start task in background pane** - Returns immediately
2. **Save pane ID** - For status checks
3. **Inform user in chat** - Task is running in background
4. **Continue with other work** - Don't wait for completion
5. **Check status if needed** - Poll pane existence
6. **Let task auto-close** - Pane exits naturally when task completes (no sleep needed)

### Display vs Task Guidelines

**Display Windows (showing context/code):**

- ✅ Use `bat` to show files
- ✅ Add header explaining what's shown
- ✅ End with "Review this, then respond in chat"
- ❌ **NEVER add `sleep`** - blocks user interaction
- 👤 User closes pane manually when done reviewing

**Task Windows (running commands):**

- ✅ Show task output/progress
- ✅ Let task complete naturally
- ✅ Pane auto-closes when command finishes
- ❌ **NEVER add `sleep` after task** - blocks terminal
- 🤖 Pane exits automatically on task completion

This pattern avoids timeouts and keeps conversation flowing naturally.
