#!/bin/bash

tmpInstallBackup="/tmp/vgaudard_dotfiles_install_sh_backupfolder/"

declare -A SYMLINKS
SYMLINKS=(
        ["bash/.bashrc"]=""
        ["bash/.bash_aliases"]=""
        ["vim/.vimrc"]=""
        [".inputrc"]=""
        ["vifm/vifmrc"]="$HOME/.vifm"
        ["awesome/rc.lua"]="$HOME/.config/awesome"
        ["awesome/lua_completion.lua"]="$HOME/.config/awesome"
        ["awesome/lua_usefuleval.lua"]="$HOME/.config/awesome"
        ["awesome/battery-warning.lua"]="$HOME/.config/awesome"
        ["awesome/precious"]="$HOME/.config/awesome"
        ["mail/.offlineimaprc"]=""
        ["mail/offlineimap.py"]="$HOME/.mutt"
        ["mail/muttrc"]="$HOME/.mutt"
        ["mail/mailcap"]="$HOME/.mutt"
        ["mail/.urlview"]=""
        ["mail/.msmtprc"]=""
        ["i3/config"]="$HOME/.config/i3"
        ["i3/.i3status.conf"]="$HOME/.config/i3/"
        )

declare -a FOLDERS
FOLDERS=(
        "$tmpInstallBackup"
        "$HOME/.vim/backup"
        "$HOME/.vim/undo"
        "$HOME/.vim/swap"
        "$HOME/.config/awesome"
        "$HOME/.mutt"
        "$HOME/.mail"
        "$HOME/.offlineimap"
        "$HOME/.mail/vgaudardgmailperso"
        "$HOME/.config/i3"
        )


declare -A REPOS
REPOS=(
        ["https://github.com/VundleVim/Vundle.vim.git"]="$HOME/.vim/bundle/Vundle.vim"
        ["https://github.com/chrjguill/i3lock-color"]="$HOME/.config/i3/i3lock-color"
        ["https://github.com/meskarune/i3lock-fancy"]="$HOME/.config/i3/i3lock-fancy"
        )

declare -a MAKETARGETS
MAKETARGETS=(
        "make -C $HOME/.config/i3/i3lock-color"
        "sudo make -C $HOME/.config/i3/i3lock-color install"
        "sudo cp $HOME/.config/i3/i3lock-fancy/lock /usr/local/bin/"
        "sudo cp $HOME/.config/i3/i3lock-fancy/lock.png /usr/local/bin/"
        "sudo cp $HOME/.config/i3/i3lock-fancy/lockdark.png /usr/local/bin/"
        )

declare -a DEPENDENCIES
DEPENDENCIES=(
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

dpkg -s "${DEPENDENCIES[@]}" > /dev/null

for d in "${FOLDERS[@]}"; do
    echo "Creating $d"
    mkdir -p $d
done

for repo in "${!REPOS[@]}"; do
    targetFolder=${REPOS["$repo"]}
    if [ ! -d "$targetFolder" ]; then
        mkdir -p "$targetFolder"
        git clone "$repo" "$targetFolder"
    fi
done

for f in "${!SYMLINKS[@]}"; do
    folder=${SYMLINKS["$f"]:-$HOME}
    basef=$(basename $f)
    if [ ! -f "$folder/$basef" ]; then
        ln -s "$(realpath $f)" "$folder/$basef"
    else
        echo "Moving $basef to $tmpInstallBackup"
        mv "$folder/$basef" "$tmpInstallBackup"
        ln -s "$(realpath $f)" "$folder/$basef"
    fi
done

for cmd in "${MAKETARGETS[@]}"; do
    echo "Executing \`$cmd\`"
    $cmd
done

