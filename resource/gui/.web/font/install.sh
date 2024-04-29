#!/bin/bash

if ! dpkg-query -W -f='${Status}' "unzip" 2>"/dev/null"\
    | grep -q "install ok installed"
then
    apt install -y "unzip" &>"/dev/null" || exit 1
    [[ "$NO_BACKUP" ]] || echo "apt:unzip" >> "$BACKUP/diff"
fi
bye(){
    chown -R "$USER:$USER" "$HOME/.cache"
    chown -R "$USER:$USER" "$HOME/.wget-hsts"
    rm -rf "$TMP"
    exit "$1"
}
NAME="Terminus"
TMP="$(mktemp -d)" || bye 1
cd "$TMP" || bye 1
mkdir "$NAME" && cd "$NAME"

P1="https://github.com/ryanoasis"
P2="/nerd-fonts/releases/download/v3.1.1/$NAME.zip"
URL="$P1$P2"
curl -kL "$URL" -o "$NAME.zip" || bye 1

unzip "$NAME.zip" >"/dev/null" || bye 1
rm -rf "$NAME.zip"

DST="/usr/local/share/fonts/$NAME"
mkdir "$DST" || bye 1
mv * "$DST" || bye 1
fc-cache -f -v >"/dev/null"
bye 0
