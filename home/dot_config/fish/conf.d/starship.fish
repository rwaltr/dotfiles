if type -q starship
    if status is-interactive
        starship init fish | source
    end
end
