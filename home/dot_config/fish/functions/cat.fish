if type -q bat
    function cat --wraps=bat --description 'bat shorthand'
        bat $argv
    end
end
