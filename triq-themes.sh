#!/bin/bash

help () {
    echo >&2 "Usage: $0 [ -list | -all | THEME... ]"
    exit 1
}

if [[ $# -eq 0 || $1 =~ ^-h || $1 =~ ^-\? ]]; then
    help
fi

conf=
if [[ -n $ICEWM_PRIVCFG ]]; then
    conf=$ICEWM_PRIVCFG
elif [[ -n $XDG_CONFIG_HOME ]]; then
    conf=$XDG_CONFIG_HOME/icewm
elif [[ -n $HOME ]]; then
    conf=$HOME/.icewm
fi
if [[ -n $conf && ! -d $conf ]]; then
    mkdir -m 0700 -v -- "$conf" >&2 || exit 1
fi
if [[ -z $conf || ! -d $conf ]]; then
    echo >&2 "$0: missing config directory"
    exit 1
fi

them=$conf/themes
if [[ ! -d $them ]]; then
    mkdir -m 0700 -v -- "$them" >&2 || exit 1
fi
if [[ -z $them || ! -d $them ]]; then
    echo >&2 "$0: missing themes directory"
    exit 1
fi

cd $them || exit 1

inst () {
    [[ -d $1 ]] && rm -rf -- "$1"
    [[ -e $1 ]] && rm -vf -- "$1"
    if [[ ! -e $1 ]]; then
        wget -O- "$2" | tar zxvf - "$1"
        [[ -d $1 ]] || exit 1
    fi
}

for f
do
    if [[ $f =~ ^liQuid || $f =~ ^liquid || $f = "-all" ]]; then
        inst liQuid "https://triq.net/files/liQuid-theme.tar.gz"
    fi
    if [[ $f =~ ^Oktan || $f =~ ^oktan || $f = "-all" ]]; then
        inst oktan "https://triq.net/files/oktan-theme.tar.gz"
    fi
    if [[ $f =~ ^Marenily || $f =~ ^marenily || $f = "-all" ]]; then
        inst marenily "https://triq.net/files/marenily-theme.tar.gz"
    fi
    if [[ $f =~ ^Sweetpill || $f =~ ^sweetpill || $f = "-all" ]]; then
        inst Sweetpill-II "https://triq.net/files/Sweetpillii-theme.tar.gz"
    fi
    if [[ $f =~ ^Lovena || $f =~ ^lovena || $f = "-all" ]]; then
        inst lovena "https://triq.net/files/lovena-theme.tar.gz"
    fi
    if [[ $f =~ ^Whiteness || $f =~ ^whiteness || $f = "-all" ]]; then
        inst whiteness "https://triq.net/files/whiteness-theme.tar.gz"
    fi
    if [[ $f =~ ^Aluminium || $f =~ ^aluminium || $f = "-all" ]]; then
        inst aluminium "https://triq.net/files/aluminium-theme.tar.gz"
    fi
    if [[ $f =~ ^Fullmoon || $f =~ ^fullmoon || $f = "-all" ]]; then
        inst fullmoon "https://triq.net/files/fullmoon-theme.tar.gz"
    fi
    if [[ $f = "-list" ]]; then
        echo "aluminium fullmoon liQuid lovena marenily oktan Sweetpill-II whiteness"
    fi
done

