# Custom Aliases

# Exit shortcuts
alias ":q" = exit
alias x = exit
alias q = exit

# Easy Open
alias open = xdg-open

# File listing
alias l = ls
alias ll = ls -l
alias la = ls -a
alias lla = ls -la

# Weather!
alias wttrv1 = curl wttr.in
alias wttrv2 = curl v2.wttr.in
alias wttr = wttrv2

# QOL - Git shortcuts
alias g = git
alias gp = git p
alias gpll = git pull
alias gc = git c -s

# Chezmoi shortcuts
alias ccd = chezmoi cd
alias cap = chezmoi apply
alias cup = chezmoi update
alias cec = chezmoi edit-config
alias ce = chezmoi edit

# GPG helpers
alias gpg-check = gpg --keyserver-options auto-key-retrieve --verify
alias gpg-retrieve = gpg --keyserver-options auto-key-retrieve --receive-keys

# Git
alias pull = git pull origin
alias push = git push origin

# IP colors
alias ip = ip -br -c

# Services - Termbin
alias tb = nc termbin.com 9999

# Argo
alias argo = argocd

# Temp directory
alias mktmp = mktemp
alias mktdir = mktemp -d

# Editor
alias nv = nvim
alias nano = nvim

# thefuck
alias f = thefuck
