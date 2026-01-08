# Homebrew - OS-specific paths
switch (uname)
    case Darwin
        # macOS - Apple Silicon
        if test -f /opt/homebrew/bin/brew
            eval "$(/opt/homebrew/bin/brew shellenv)"
        # macOS - Intel
        else if test -f /usr/local/bin/brew
            eval "$(/usr/local/bin/brew shellenv)"
        end
    case Linux
        # Linuxbrew
        if test -f /home/linuxbrew/.linuxbrew/bin/brew
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        end
end
if type -q mise
    mise activate fish | source
end
fish_add_path ~/.local/bin
