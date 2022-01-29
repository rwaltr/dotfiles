if status is-interactive
    # Commands to run in interactive sessions can go here
  if type -q gnome-keyring-daemon 
bass eval (gnome-keyring-daemon --start)
export SSH_AUTH_SOCK
  end
set -gx CDPATH ".:~:~/src/rwaltr:~/src/"
fish_vi_key_bindings
set -gx HISTSIZE 10000
end
