{{- if eq .chezmoi.os "linux" }}
#!/bin/bash
{{- if eq .chezmoi.osRelease.name "Fedora" }}
echo "Installing packages"
sudo dnf update -y
sudo dnf install toilet git wget curl -y
toilet --metal "Installing RPM Fusion"
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
toilet --metal "RPMFUSION UPDATES"
sudo dnf groupupdate core -y
toilet "Installing Basic Tools" --metal
sudo dnf install -y neovim lsd jq 
toilet "Updating Vim"
nvim --headless -c PlugInstall
{{- end }}
{{- end }}
