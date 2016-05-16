#!/bin/bash

declare -A SYMLINKS
SYMLINKS=(["bash/.bashrc"]=""
          ["bash/.bash_aliases"]=""
          ["vim/.vimrc"]=""
          [".inputrc"]=""
          ["vifm/vifmrc"]="$HOME/.vifm"
          ["awesome/rc.lua"]="$HOME/.config/awesome"
          ["awesome/lua_completion.lua"]="$HOME/.config/awesome"
          ["awesome/lua_usefuleval.lua"]="$HOME/.config/awesome"
          ["awesome/battery-warning.lua"]="$HOME/.config/awesome"
          ["awesome/precious"]="$HOME/.config/awesome")

FOLDERS=("$HOME/.vim/backup"
         "$HOME/.vim/undo"
         "$HOME/.vim/swap"
         "$HOME/.config/awesome")

for d in "$FOLDERS"; do
    mkdir -p $d
done

if [ ! -d ~/.vim/bundle/Vundle.vim/ ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

for f in "${!SYMLINKS[@]}"; do
    folder=${SYMLINKS["$f"]:-$HOME}
    basef=$(basename $f)
    if [ ! -f "$folder/$basef" ]; then
        ln -s "$(realpath $f)" "$folder/$basef"
    else
        echo "$f already exists in $folder"
        echo "Do you want to replace the current $basef in $folder with a symlink to $(realpath $f) ? (y/N)"
        if diff "$f" "$folder/$basef" > /dev/null ; then
            echo "(Files have the same content)"
        else
            echo "(Files do not have the same content)"
        fi
        read ans
        case $ans in
            y|Y)
                rm "$folder/$basef"
                ln -s "$(realpath $f)" "$folder/$basef"
                ;;
            *)
                ;;
        esac
    fi
done

