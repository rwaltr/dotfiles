# Override distro/vendor fish_greeting (eg. zmotd) with user greeting.
if test -f ~/.config/fish/functions/fish_greeting.fish
    source ~/.config/fish/functions/fish_greeting.fish
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    # bass eval (gnome-keyring-daemon)
    # set -Ux SSH_AGENT_PID $SSH_AGENT_PID
    # set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
    set -gx HISTSIZE 10000
    fish_vi_key_bindings


end
