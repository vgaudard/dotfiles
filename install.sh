#!/bin/bash

declare -a SYMLINKS
SYMLINKS=(".bashrc .bash_aliases .vimrc .inputrc")

for f in $SYMLINKS; do
    if [ ! -f "$HOME/$f" ]; then
        ln -s "$(realpath $f)" "$HOME/$f"
    else
        echo "$f already exists in $HOME"
        echo "Do you want to replace the current $f in $HOME with a symlink to $(realpath $f) ? (y/N)"
        if diff "$f" "$HOME/$f" > /dev/null ; then
            echo "(Files have the same content)"
        else
            echo "(Files do not have the same content)"
        fi
        read ans
        case $ans in
            y|Y)
                rm "$HOME/$f"
                ln -s "$(realpath $f)" "$HOME/$f"
                ;;
            *)
                ;;
        esac
    fi
done

