# fix git clone fuckups
git-https-to-ssh () {
    url="$(git remote -v | head -n 1 | awk '{print $2}')"
    echo "Old remote: ${url}"
    hostname="$(cut -f3 -d/ <<< $url)"
    userandrepo="$(cut -f4- -d/ <<< $url)"
    newremote="git@${hostname}:${userandrepo}.git"
    git remote set-url origin ${newremote}
    echo "New remote: ${newremote}"
}
