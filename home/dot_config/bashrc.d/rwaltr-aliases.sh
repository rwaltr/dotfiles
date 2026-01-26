# Custom Alias
# shellcheck shell=bash

alias ":q"="exit"
alias "x"="exit"
alias "q"="exit"

# easy resource
alias resource="source ~/.bashrc"

# Easy Open
alias open="xdg-open"

# File listing
alias l="ls"
alias ls="ls --color"
alias ll="ls -lh"
alias la="ls -ah"
alias lla="ls -lah"

# Weather!
alias wttrv1="curl wttr.in"
alias wttrv2="curl v2.wttr.in"
alias wttr=wttrv2

# Easy upward navigation
alias ..="cd .."
alias ...="cd ../../../"
alias ....="cd ../../../../"
alias .....="cd ../../../../../"
alias cd..=".."

#QOL
alias g="git"
alias gp="git p"
alias gpll="git pull"
alias gc="git c -s"
alias ccd="chezmoi cd"
alias cap="chezmoi apply"
alias cup="chezmoi update"
alias cec="chezmoi edit-config"
alias ce="chezmoi edit"

#GPG helpers
# verify signature
alias gpg-check="gpg --keyserver-options auto-key-retrieve --verify"
# receive the key of a developer
alias gpg-retrieve="gpg --keyserver-options auto-key-retrieve --receive-keys"

# git
alias pull='git pull origin'
alias push='git push origin'

# IP colors
alias ip='ip -br -c'

# Services
# Termbin
alias tb="nc termbin.com 9999"

# Argo!
alias argo=argocd
