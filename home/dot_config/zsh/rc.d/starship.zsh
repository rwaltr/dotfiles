# Starship prompt configuration
if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
    
    # Transient prompt support for zsh
    # Note: Fish's transient prompt is more advanced, 
    # ZSH needs additional configuration for full equivalent
fi
