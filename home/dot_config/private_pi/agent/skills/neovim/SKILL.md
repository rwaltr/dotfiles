---
name: neovim
description: Neovim configuration, Lua scripting, plugin management, LSP setup, and editor workflow optimization
---

# Neovim Configuration

Use this skill when working with Neovim configuration, Lua scripting, or editor optimization.

## Activation Triggers

Activate this skill when the user mentions:
- Neovim or nvim configuration
- Lua scripting for editor
- Plugin management
- LSP configuration
- Editor keymaps or automation
- Text editing workflows

## Capabilities

This skill provides:
- Lua-based Neovim configuration assistance
- Plugin management with lazy.nvim
- LSP setup and optimization
- Keymap configuration
- Terminal integration within nvim
- Editor workflow optimization

## Available Tools

- **nvim**: Primary editor with Lua configuration
- **git**: For configuration version control
- **mise**: For LSP server management
- **curl**: For plugin downloads and updates

## Context Awareness

### Directory Structure
- Look for `~/.config/nvim/` configuration
- Check for lua files and plugin configs
- Identify language-specific setups

### User Environment
- Neovim is the primary editor
- Lua-based configuration preferred
- CLI-integrated workflow
- Development-focused setup

## Common Operations

### Configuration Management
- Lua configuration file organization
- Plugin installation and configuration
- Keymap setup and optimization
- Autocommand configuration

### Language Server Setup
- LSP configuration for various languages
- Mason integration for server management
- Completion and snippet setup
- Debugging configuration

### Workflow Integration
- Terminal integration within nvim
- Git integration (fugitive, gitsigns)
- File navigation (telescope, nvim-tree)
- Project management

## Best Practices to Follow

- Use Lua for configuration (prefer over Vimscript)
- Organize configuration modularly
- Use lazy loading for plugins
- Implement proper LSP setup
- Configure efficient keymaps
- Maintain backward compatibility
- Document custom functions and keymaps