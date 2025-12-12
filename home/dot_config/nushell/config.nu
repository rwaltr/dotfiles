# Nushell Configuration
# Converted from Fish/ZSH config

# Hide the banner
$env.config.show_banner = false

# Starship prompt
use ~/.cache/starship/init.nu

# Load carapace completions  
source $"($nu.cache-dir)/carapace.nu"

# Source additional config modules
source ~/.config/nushell/aliases.nu
source ~/.config/nushell/kubectl.nu
source ~/.config/nushell/functions.nu
