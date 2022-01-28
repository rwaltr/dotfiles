if type -q nvim
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx KUBE_EDITOR nvim
alias vim nvim
alias vi nvim
alias nano nvim
else
alias nvim vim
end
