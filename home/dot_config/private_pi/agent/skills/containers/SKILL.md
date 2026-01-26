---
name: containers
description: Podman operations, Containerfile/Dockerfile creation, rootless containers, image building, and container security
---

# Container Management

Use this skill when working with containers, Podman operations, or container-based workflows.

## Activation Triggers

Activate this skill when the user mentions:
- Podman commands or container operations
- Docker/Containerfile creation
- Container networking or storage
- Image building or management
- Rootless container workflows
- Container security practices

## Capabilities

This skill provides:
- Podman command assistance and best practices
- Containerfile/Dockerfile optimization
- Container networking and storage solutions
- Image building and management
- Security-focused container practices
- Multi-architecture container support

## Available Tools

- **podman**: Primary container runtime (rootless by default)
- **git**: For Containerfile version control
- **nvim**: For editing Containerfiles and configs
- **curl**: For testing containerized services

## Context Awareness

### Directory Structure
- Look for Containerfile/Dockerfile in current directory
- Check for docker-compose.yml or podman-compose files
- Identify container-based project structures

### User Environment
- Rootless containers are preferred
- Security-conscious approach
- CLI-focused workflows
- Integration with development environments

## Common Operations

### Container Lifecycle
- Building images from Containerfiles
- Running containers with proper security
- Managing container storage and networking
- Container debugging and troubleshooting

### Image Management
- Multi-stage builds for optimization
- Registry operations (push/pull)
- Image security scanning
- Layer optimization

### Development Workflows
- Development container setup
- Volume mounting for code
- Port forwarding for services
- Integration with Distrobox

## Best Practices to Follow

- Use rootless containers by default
- Implement multi-stage builds for smaller images
- Follow principle of least privilege
- Use specific image tags, avoid 'latest'
- Implement proper health checks
- Optimize for security and performance
- Use non-root users in containers