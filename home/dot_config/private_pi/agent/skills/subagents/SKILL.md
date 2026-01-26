---
name: subagents
description: Use this to run another version of yourself to focus on another task
---
# Subagent Skill

## Purpose

Run additional `pi` agent instances directly to handle complex tasks that require autonomous decision-making. Use this when YOU need help, not to show the user something.

## Core Principle

**You run the subagent yourself** - Don't wait for the user to tell you to check results. Run it, get the results, and report back.

## When to Use Subagents

**Use `pi -p` directly when:**

- Task requires complex analysis or decision-making
- Need to process large amounts of data
- Want autonomous multi-step execution
- Task is well-defined with clear outputs
- You need results to continue your work

**Don't use subagents when:**

- Simple command would work (`grep`, `find`, `kubectl`)
- Just showing user something (use WezTerm skill instead)
- Task requires user interaction
- Results need user review before proceeding

## Basic Pattern

```bash
# Run subagent and capture results
pi --no-session -p "Task description with clear goals and output format"

# Use results immediately
# Continue with your work based on output
```

## Example Use Cases

### 1. Code Analysis

```bash
# Analyze code for patterns
analysis=$(pi --no-session -p "Analyze all Python files in src/ for deprecated function usage. List each occurrence with file, line number, and suggested replacement. Format as: FILE:LINE:FUNCTION -> REPLACEMENT")

# Use the analysis
echo "$analysis"
# Continue based on findings
```

### 2. Generate Configuration

```bash
# Generate config from template
pi --no-session -p "Generate a Kubernetes deployment manifest for app 'myapp' with 3 replicas, using image 'myapp:v1.0', expose port 8080, add resource limits. Save to k8s/deployment.yaml"

# Verify it was created
ls -l k8s/deployment.yaml
```

### 3. Data Processing

```bash
# Process log files
pi --no-session -p "Parse access.log and create a summary of: top 10 IPs by request count, top 10 endpoints, error rate per hour. Save as JSON to /tmp/log-summary.json"

# Read and use results
cat /tmp/log-summary.json
```

### 4. Automated Troubleshooting

```bash
# Investigate issue
pi --no-session -p "Check why pod 'myapp-123' is crashlooping. Review logs, describe pod, check events. Summarize root cause and suggest fix."

# Apply suggested fix based on output
```

### 5. Research and Documentation

```bash
# Research a topic
pi --no-session -p "Research best practices for Kubernetes resource limits. Create a markdown guide with examples for CPU/memory limits for web apps, workers, and databases. Save to docs/k8s-resources.md"

# Reference the documentation
cat docs/k8s-resources.md
```

## Best Practices

1. **Use `--no-session`** - Subagents don't need to save sessions
2. **Be specific** - Clear task description, expected format, output location
3. **Define outputs** - Tell agent where to save results or what to return
4. **Run synchronously** - Wait for completion, get results, continue
5. **Check results** - Verify output before using it
6. **Handle errors** - Check exit codes or output for failures
7. **Use for YOUR work** - Not to show user something (use WezTerm for that)

## Pattern: Run and Use Results

```bash
# 1. Run subagent with clear task
result=$(pi --no-session -p "Find all TODO comments in the codebase. Format as FILE:LINE:TODO_TEXT")

# 2. Check if successful
if [[ -n "$result" ]]; then
    # 3. Use results
    echo "Found TODOs:"
    echo "$result"
    
    # 4. Continue based on results
    # Report to user or take action
else
    echo "No TODOs found or task failed"
fi
```

## Integration with WezTerm

**Don't confuse these patterns:**

**Subagent (this skill):**

- Run directly with `pi -p`
- YOU use the results
- Synchronous execution
- For YOUR work

**WezTerm background (WezTerm skill):**

- Run in pane: `wezterm cli spawn -- pi -p`
- USER watches progress
- Asynchronous execution  
- For parallel/long tasks user monitors

## Common Mistakes to Avoid

❌ **Don't**: Run subagent in WezTerm and forget to check results

```bash
wezterm cli spawn -- pi -p "analyze code"  # BAD - who checks results?
```

✅ **Do**: Run directly and use results

```bash
pi -p "analyze code"  # GOOD - you get results immediately
```

❌ **Don't**: Use subagent just to show user something

```bash
pi -p "show me the config"  # BAD - just use bat
```

✅ **Do**: Use for actual processing

```bash
pi -p "validate config and list errors"  # GOOD - processing task
```

## Workflow

1. **Identify task** - Complex processing, analysis, or generation
2. **Define clear goal** - What output do you need?
3. **Run subagent** - `pi --no-session -p "task"`
4. **Capture results** - Variable, file, or stdout
5. **Verify output** - Check it worked
6. **Use results** - Continue your work
7. **Report to user** - Summarize what you learned/did

This skill is about YOU getting help, not about showing the user something.
