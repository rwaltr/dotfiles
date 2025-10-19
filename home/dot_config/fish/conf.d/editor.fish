if type -q nvim
    set -gx EDITOR nvim
    set -gx KUBE_EDITOR EDITOR
    alias nv nvim
    alias nano nvim
end
