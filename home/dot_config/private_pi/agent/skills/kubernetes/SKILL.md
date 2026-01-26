---
name: kubernetes
description: Kubectl commands, Kubernetes manifests, cluster management, resource operations, and debugging k8s workloads
---

# Kubernetes Management

Use this skill when working with Kubernetes clusters, resources, or kubectl operations.

## Activation Triggers

Activate this skill when the user mentions:
- kubectl commands or Kubernetes resources
- Cluster management operations
- Pod, deployment, service operations
- Manifest creation or debugging
- Kubeconfig management
- Kubernetes troubleshooting

## Capabilities

This skill provides:
- Kubectl command assistance and best practices
- Kubernetes manifest generation and validation
- Cluster debugging and troubleshooting
- Resource management optimization
- Security and RBAC guidance
- Custom resource operations

## Available Tools

- **kubectl**: Primary Kubernetes CLI tool with custom aliases
- **git**: For manifest version control
- **nvim**: For editing YAML manifests
- **curl**: For API testing and health checks

## Context Awareness

### Directory Structure
- Look for Kubernetes manifests in current directory
- Check for kustomization files
- Identify if in a k8s project structure

### User Environment
- User has extensive kubectl aliases configured
- Custom kubeconfig management setup
- Prefers CLI-based workflows
- Security-conscious approach (RBAC, least privilege)

## Common Operations

### Resource Management
- Creating and managing pods, deployments, services
- Scaling and updating deployments
- Configmap and secret management
- Persistent volume operations

### Debugging and Troubleshooting
- Pod logs and events analysis
- Network connectivity issues
- Resource quota and limit problems
- RBAC permission debugging

### Manifest Operations
- YAML generation and validation
- Kustomize operations
- Helm chart management
- GitOps workflow support

## Best Practices to Follow

- Always check current context before operations
- Use namespaces appropriately
- Follow security best practices (RBAC, network policies)
- Validate manifests before applying
- Use labels and selectors effectively
- Implement proper resource limits and requests