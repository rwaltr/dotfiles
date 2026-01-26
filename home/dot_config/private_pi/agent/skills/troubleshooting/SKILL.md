---
name: troubleshooting
description: Debugging Linux systems, CLI tools, performance issues, network problems, and service management
---

# CLI Troubleshooting

Use this skill when debugging Linux systems, CLI tools, or resolving technical issues.

## Activation Triggers

Activate this skill when the user mentions:
- System or service debugging
- CLI tool problems
- Performance issues
- Network connectivity problems
- File system or permission issues
- Process or resource problems

## Capabilities

This skill provides:
- System diagnostics and monitoring
- Process and resource troubleshooting
- Network connectivity debugging
- File system and permission resolution
- Service and systemd management
- Performance analysis and optimization

## Available Tools

- **Standard Linux tools**: ps, top, htop, ss, netstat, lsof, etc.
- **Systemd tools**: systemctl, journalctl
- **Network tools**: ping, curl, nc, ip
- **File tools**: ls, find, stat, chmod
- **Container tools**: podman, distrobox for isolation

## Context Awareness

### System Environment
- Linux daily driver with systemd
- Container-based workflows
- CLI-focused troubleshooting
- Security-conscious approach

### User Preferences
- Prefer CLI diagnostic tools
- Container isolation when debugging
- Root cause analysis approach
- Documentation of solutions

## Common Operations

### System Diagnostics
- Process and resource monitoring
- Service status and log analysis
- Network connectivity testing
- File system permission debugging

### Performance Analysis
- CPU and memory usage investigation
- I/O performance measurement
- Network latency and throughput
- Container resource analysis

### Security Troubleshooting
- Permission and ownership issues
- SSH and authentication problems
- Container security debugging
- Service access control

## Best Practices to Follow

- Start with non-invasive diagnostics
- Use container isolation for testing
- Document findings and solutions
- Follow principle of least privilege
- Verify fixes don't break other functionality
- Consider security implications of changes
- Use version control for configuration changes