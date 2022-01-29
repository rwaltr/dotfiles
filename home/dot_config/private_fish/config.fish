if status is-interactive
    # Commands to run in interactive sessions can go here
  if type -q gnome-keyring-daemon 
bass eval (gnome-keyring-daemon --start)
export SSH_AUTH_SOCK
  end
fish_add_path ~/.local/bin
fish_add_path ~/bin
end
