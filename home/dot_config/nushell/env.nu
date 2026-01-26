# vi: ft=nu
# Nushell Environment Configuration

# Path configuration - prepend to PATH
$env.PATH = ($env.PATH | split row (char esep) | prepend [
    ($env.HOME | path join ".local" "bin")
])

# Editor
if (which nvim | is-not-empty) {
    $env.EDITOR = "nvim"
    $env.KUBE_EDITOR = $env.EDITOR
}

# Pi agent configuration
$env.PI_CODING_AGENT_DIR = ($env.HOME | path join ".config" "pi" "agent")

# Aqua package manager
if (which aqua | is-not-empty) {
    $env.AQUA_CONFIG = ($env.HOME | path join ".config" "aqua" "aqua.yaml")
    $env.AQUA_GLOBAL_CONFIG = ($env.HOME | path join ".config" "aqua" "aqua.yaml")
    $env.AQUA_ROOT_DIR = ($env.HOME | path join ".local" "share" "aqua")
    $env.PATH = ($env.PATH | split row (char esep) | prepend ($env.AQUA_ROOT_DIR | path join "bin"))
}

# Krew kubectl plugin manager
if (which kubectl | is-not-empty) {
    $env.KREW_ROOT = ($env.HOME | path join ".local" "share" "krew")
    $env.PATH = ($env.PATH | split row (char esep) | prepend ($env.KREW_ROOT | path join "bin"))
}

# CDPATH configuration
$env.CDPATH = [. ~ ~/src/rwaltr ~/src/ ~/Documents]

# Go configuration (commented out in original)
# $env.GOPATH = ($env.HOME | path join ".local" "share" "go")
# $env.GOBIN = ($env.HOME | path join ".local" "bin")

# Carapace completions
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'
mkdir $"($nu.cache-dir)"
carapace _carapace nushell | save --force $"($nu.cache-dir)/carapace.nu"

# Starship prompt initialization
mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu
