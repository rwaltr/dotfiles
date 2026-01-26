Analyze and work with the current project or directory context.

## Directory Analysis

**Current location**: `pwd`
**Available tools**: {{tools}}
**Project type**: {{project-type}}

## Common Operations

### Repository Information

```bash
# Git repository details
git remote -v
git status
git log --oneline -5

# GitHub integration
gh repo view
gh issue list
gh pr status
```

### Project Structure

```bash
# Directory overview
ls -la
tree -L 2  # If available
find . -type f -name "*.md" | head -5
```

### Tool Context

```bash
# Available development tools
mise list
which {{tool-name}}
{{tool-name}} --version
```

### Project Dependencies

```bash
# Language-specific dependency files
ls -la package.json Cargo.toml go.mod requirements.txt Gemfile 2>/dev/null || echo "No standard dependency files found"
```

## Analysis Questions

1. **What type of project is this?**
   - Programming language
   - Framework or technology stack
   - Build system or tooling

2. **What's the current state?**
   - Git repository status
   - Uncommitted changes
   - Recent activity

3. **What tools are available?**
   - mise-managed tools
   - System tools
   - Project-specific tooling

4. **What can be optimized?**
   - Development workflow
   - Automation opportunities
   - Configuration improvements

