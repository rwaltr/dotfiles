function starship_transient_prompt_func
    echo (starship module character)
end
function starship_transient_rprompt_func
    starship module time
end

if status is-interactive
    if type -q starship
        starship init fish | source
        enable_transience
    end
end
