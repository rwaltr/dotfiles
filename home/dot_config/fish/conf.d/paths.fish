if type -f /home/linuxbrew/.linuxbrew/bin/brew
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
end
if type -q mise
    mise activate fish | source
end
fish_add_path ~/.local/bin
