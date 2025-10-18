# Custom Alias

alias ":q"="exit"
alias "x"="exit"
alias "q"="exit"

# easy resource
alias resource="source ~/.bashrc"

#Vimwiki alias

# Easy Open
alias open="xdg-open"

# File listing
alias l="ls"
alias ls="ls --color"
alias ll="ls -lh"
alias la="ls -ah"
alias lla="ls -lah"

# Easy upward navigation
alias ..="cd .."
alias ...="cd ../../../"
alias ....="cd ../../../../"
alias .....="cd ../../../../../"
alias cd..=".."


#QOL
#Forgot a space
alias sudo!="sudo !!"

#GPG helpers
# verify signature
alias gpg-check="gpg --keyserver-options auto-key-retrieve --verify"
# receive the key of a developer
alias gpg-retrieve="gpg --keyserver-options auto-key-retrieve --receive-keys"

# git
alias addup='git add -u'
alias addall='git add .'
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit -m'
alias fetch='git fetch'
alias pull='git pull origin'
alias push='git push origin'
alias status='git status'
alias tag='git tag'
alias newtag='git tag -a'
alias gdiff='git diff'

# IP colors
alias ip='ip -br -c'


# Argo!
alias argo=argocd

