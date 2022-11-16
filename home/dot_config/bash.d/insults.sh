insults () {
echo -e "You failed... here's a bash.org IRC quote:\n  $(curl -s http://bash.org/?random1|grep -oE "<p class=\"quote\">.*</p>.*</p>"|grep -oE "<p class=\"qt.*?</p>"|sed 's/<\/p>/\n/g;s/<p class=\"qt\">//g;s/<p class=\"qt\">//g;s/&lt;/</g;s/&gt;/>/g;s/&quot;/"/g;s/&nbsp//g' | head -n1)"
}

