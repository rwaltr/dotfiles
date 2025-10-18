# vi: ft=nu
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir $"($nu.cache-dir)"
carapace _carapace nushell | save --force $"($nu.cache-dir)/carapace.nu"

# ${UserConfigDir}/nushell/config.nu
source $"($nu.cache-dir)/carapace.nu"
