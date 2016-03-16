#!/bin/bash

declare -a SYMLINKS
SYMLINKS=(".bashrc .bash_aliases .vimrc .inputrc")

for f in $SYMLINKS; do
    if [ ! -f "$f" ] || [ ! -f "$HOME/$f" ]; then
        rm "$HOME/$f"
        ln -s "$(realpath $f)" "$HOME/$f"
    else
        #dialog --yesno "$f is not the same in current folder $(pwd -P)) and in $HOME\nDo you want to replace the current $f in $HOME with a symlink to $(realpath $f) ? (y/N)" 20 60
        #if [ "$?" -eq 0 ] ; then
        echo "$f already exists in $HOME"
        echo "Do you want to replace the current $f in $HOME with a symlink to $(realpath $f) ? (y/N)"
        read ans
        case $ans in
            y|Y)

                echo "symlinking"
                rm "$HOME/$f"
                ln -s "$(realpath $f)" "$HOME/$f"
                ;;
            *)
                echo "Ok"
        esac
    fi
done

