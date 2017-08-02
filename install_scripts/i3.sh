#!/bin/bash

I3DIR="$HOME/.config/i3"
SYMLINKS["i3/config"]="$I3DIR"
SYMLINKS["i3/.i3status.conf"]=""

FOLDERS+=(
        "$I3DIR"
        )

REPOS+=(
        ["https://github.com/vgaudard/i3lock-color.git"]="$I3DIR/i3lock-color"
        ["https://github.com/vgaudard/i3lock-fancy.git"]="$I3DIR/i3lock-fancy"
        ["https://github.com/vgaudard/i3status.git"]="$I3DIR/i3status"
        )

MAKETARGETS+=(
        "make -C $I3DIR/i3lock-color"
        "sudo make -C $I3DIR/i3lock-color install"
        "sudo make -C $I3DIR/i3lock-fancy ICONSFAMILY=shield"
        "make -C $I3DIR/i3status"
        "sudo make -C $I3DIR/i3status install"
        )

DEPENDENCIES+=(
        "imagemagick"
        "j4-dmenu-desktop"
        "libcairo-dev"
        "libev-dev"
        "libpam-dev"
        "libx11-dev"
        "libx11-xcb-dev"
        "libxcb-composite0-dev"
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
        "util-linux"
        "pkg-config"
        )


