#!/bin/bash

SYMLINKS["i3/config"]="$HOME/.config/i3"
SYMLINKS["i3/.i3status.conf"]="$HOME/.config/i3/"

FOLDERS+=(
        "$HOME/.config/i3"
        )

REPOS+=(
        ["https://github.com/chrjguill/i3lock-color"]="$HOME/.config/i3/i3lock-color"
        ["https://github.com/meskarune/i3lock-fancy"]="$HOME/.config/i3/i3lock-fancy"
        )

MAKETARGETS+=(
        "make -C $HOME/.config/i3/i3lock-color"
        "sudo make -C $HOME/.config/i3/i3lock-color install"
        "sudo cp $HOME/.config/i3/i3lock-fancy/lock /usr/local/bin/"
        "sudo cp $HOME/.config/i3/i3lock-fancy/lock.png /usr/local/bin/"
        "sudo cp $HOME/.config/i3/i3lock-fancy/lockdark.png /usr/local/bin/"
        )

DEPENDENCIES+=(
        "awk"
        "bash"
        "imagemagick"
        "libcairo-dev"
        "libev-dev"
        "libpam-dev"
        "libx11-dev"
        "libx11-xcb-dev"
        "libxcb-dpms0-dev"
        "libxcb-image0-dev"
        "libxcb-util0-dev"
        "libxcb-xinerama0-dev"
        "libxcb-xkb-dev"
        "libxcb1"
        "libxkbcommon-x11-0"
        "libxkbcommon-x11-dev"
        "libxkbcommon0"
        "scrot"
        "utils-linux"
        "pkg-config"
        )


