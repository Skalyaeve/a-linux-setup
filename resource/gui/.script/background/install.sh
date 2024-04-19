#!/bin/bash
#======================= LIGHTDM BACKGROUNDS
FROM='/usr/share/images/desktop-base'
TO="/usr/share/images/backgrounds"

TMP="$(mktemp -d)" || exit 1
cd "$TMP" || exit 1

doit() {
    local target="$1"
    local files=("${@:2}")
    for file in "${files[@]}";do
        [[ -e "$FROM/$file" ]] || continue
        if ! diff "$FROM/$file" "$target";then
            local dontstop=1
            break
        fi
    done
    [[ "$dontstop" ]] || return 0

    if [[ ! -w "$FROM" ]]; then
        echo "Permission denied: $FROM" 1>&2
        return 1
    fi
    [[ -e "$TO/$target" ]]\
        && ! mv "$TO/$target" "$TO/$target.ft.bak"\
        && return 1

    if ! mv "$target" "$TO/$target";then
        mv "$TO/$target.ft.bak" "$TO/$target"
        return 1
    fi
    for file in "${files[@]}";do
        if [[ -e "$FROM/$file" ]]\
            && ! mv "$FROM/$file" "$FROM/$file.ft.bak"
        then
            for old in "${files[@]}";do
                [[ "$file" == "$old" ]] && break
                mv "$FROM/$old.ft.bak" "$FROM/$old"
            done
            mv "$TO/$target.ft.bak" "$TO/$target"
            return 1
        fi
        if ! ln -s "$TO/$target" "$FROM/$file";then
            for old in "${files[@]}";do
                mv "$FROM/$old.ft.bak" "$FROM/$old"
                [[ "$file" == "$old" ]] && break
            done
            mv "$TO/$target.ft.bak" "$TO/$target"
            return 1
        fi
    done
    return 0
}

NAME="background.jpg"
FILES=(
    "default"
    "desktop-background"
    "desktop-grub.png"
    "login-background.svg"
)
P1="https://github.com/Skalyaeve"
P2="/images/blob/main/background/$NAME"
URL="$P1$P2"
curl -kL "$URL" -o "$NAME" && doit "$NAME" "${FILES[@]}"
if [[ "$?" -eq 0 ]];then
    NAME="background.xml"
    FILES=(
        "desktop-background.xml"
        "desktop-lockscreen.xml"
    )
    P1="https://raw.githubusercontent.com/Skalyaeve"
    P2="/images/main/background/$NAME"
    URL="$P1$P2"
    curl -k "$URL" > "$NAME" && doit "$NAME" "${FILES[@]}"
fi

#======================= GRUB BACKGROUND
bye() {
    rm -rf "$TMP"
    exit "$1"
}
NAME="black.png"
P1="https://raw.githubusercontent.com/Skalyaeve"
P2="/images/main/background/$NAME"
URL="$P1$P2"
curl -kL "$URL" -o "$NAME"
DST="/boot/grub"
if [[ -e "$DST/$NAME" ]];then
    diff "$NAME" "$DST/$NAME" && bye 0
    mv "$DST/$NAME" "$DST/$NAME.ft.bak" || bye 1
fi
mv "$NAME" "$DST/$NAME" || bye 1

SRC="$HOME/.local/share/setup/gui/grub/grub"
DST="/etc/default/grub"
if [[ -e "$DST" ]];then
    diff "$SRC" "$DST" && bye 0
    mv "$DST" "$DST.ft.bak" || bye 1
fi
cp "$SRC" "$DST" || bye 1
update-grub
bye 0
