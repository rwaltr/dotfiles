if type -q curl && type -q fzf
function getunloccode
    curl -s https://raw.githubusercontent.com/datasets/un-locode/master/data/code-list.csv | fzf -d , -i --height=10% --with-nth=2,3,5,6 | cut -d, -f2,3 --output-delimiter=","
end
end
