if status is-interactive
    # Commands to run in interactive sessions can go here
    if type -q gnome-keyring-daemon
        bass eval (gnome-keyring-daemon --start)
        set -Ux SSH_AGENT_PID $SSH_AGENT_PID
        set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
    end
    set -gx CDPATH ".:~:~/src/rwaltr:~/src/"
    set -gx HISTSIZE 10000
    fish_vi_key_bindings
    set -U fish_greeting
end
