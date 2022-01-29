if status is-interactive
    # Commands to run in interactive sessions can go here
bass eval (gnome-keyring-daemon --start)
export SSH_AUTH_SOCK
fish_add_path ~/.local/bin
fish_add_path ~/bin
end
