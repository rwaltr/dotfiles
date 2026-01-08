# Homebrew - OS-specific paths
switch (uname)
    case Darwin
        # macOS - Apple Silicon
        if test -f /opt/homebrew/bin/brew
            /opt/homebrew/bin/brew shellenv | source
        # macOS - Intel
        else if test -f /usr/local/bin/brew
            /usr/local/bin/brew shellenv | source
        end
    case Linux
        # Linuxbrew
        if test -f /home/linuxbrew/.linuxbrew/bin/brew
            /home/linuxbrew/.linuxbrew/bin/brew shellenv | source
        end
end
if type -q mise
    mise activate fish | source
end
fish_add_path ~/.local/bin
