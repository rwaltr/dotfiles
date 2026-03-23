# yazi — terminal file manager with directory changing on exit
if type -q yazi
    function y
        set -l tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if set -l cwd (command cat -- "$tmp"); and test -n "$cwd"; and test "$cwd" != "$PWD"
            cd -- "$cwd"
        end
        rm -f -- "$tmp"
    end
end
