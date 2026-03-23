# Homebrew (Linuxbrew)
if test -f /home/linuxbrew/.linuxbrew/bin/brew
    /home/linuxbrew/.linuxbrew/bin/brew shellenv | source
end
if type -q mise
    mise activate fish | source
end
fish_add_path ~/.local/bin
