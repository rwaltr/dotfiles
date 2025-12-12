# ZSH Plugin Equivalents

This file lists ZSH plugin equivalents for the Fish plugins listed in `fish_plugins`.

## Fish Plugins (Reference)

From `fish_plugins`:
- awinecki/fish-kubecolor-completions
- danhper/fish-ssh-agent
- decors/fish-colored-man
- edc/bass
- evanlucas/fish-kubectl-completions
- franciscolourenco/done
- jorgebucaran/autopair.fish
- jorgebucaran/fisher
- jorgebucaran/spark.fish
- kidonng/zoxide.fish
- nickeb96/puffer-fish
- oh-my-fish/plugin-bang-bang
- patrickf3139/fzf.fish
- wfxr/forgit

## ZSH Equivalents (Recommended)

### Plugin Manager
- **zinit** or **oh-my-zsh** (instead of fisher)

### Completions
- **zsh-kubectl-prompt** (kubectl context in prompt)
- Built-in zsh completions or **zsh-completions**

### Utilities
- **zsh-autosuggestions** (autocomplete from history)
- **zsh-syntax-highlighting** (syntax highlighting)
- **fzf-tab** (fzf integration for tab completion)
- **zoxide** (z-style directory jumping - same as fish plugin)
- **forgit** (same tool, works with zsh)
- **autopair** (zsh-autopair)

### Nice-to-have
- **colored-man-pages** (oh-my-zsh plugin)
- **command-not-found** (suggests packages)

### SSH Agent
- Built-in zsh ssh-agent plugin or **keychain**

### Done Notifications
- **zsh-notify** or similar

## Installation

For zinit (recommended):
```zsh
# In ~/.zshrc
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab
```

For oh-my-zsh:
```zsh
# In ~/.zshrc
plugins=(
    git
    kubectl
    zoxide
    colored-man-pages
    command-not-found
    ssh-agent
)
```
