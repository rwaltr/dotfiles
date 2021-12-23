# Source fzf
if [ -d /usr/share/fzf/shell  ]
  then
source /usr/share/fzf/shell/key-bindings.bash
fi


fzopen (){
fd -t f -H -I | fzf -m --preview="xdg-mime query default {}" | xargs -ro -d "\n" xdg-open 2>&-
}

fzdopen (){
fd -t d -H -I | fzf  --preview="ls {}" | xargs -ro -d cd
}
