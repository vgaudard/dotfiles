#!/bin/bash

declare -A SYMLINKS
SYMLINKS=([".bashrc"]=""
          [".bash_aliases"]=""
          [".vimrc"]=""
          [".inputrc"]=""
          ["vifmrc"]="$HOME/.vifm"
          ["rc.lua"]="$HOME/.config/awesome")

for f in "${!SYMLINKS[@]}"; do
    folder=${SYMLINKS["$f"]:-$HOME}
    if [ ! -f "$folder/$f" ]; then
        ln -s "$(realpath $f)" "$folder/$f"
    else
        echo "$f already exists in $folder"
        echo "Do you want to replace the current $f in $folder with a symlink to $(realpath $f) ? (y/N)"
        if diff "$f" "$folder/$f" > /dev/null ; then
            echo "(Files have the same content)"
        else
            echo "(Files do not have the same content)"
        fi
        read ans
        case $ans in
            y|Y)
                rm "$folder/$f"
                ln -s "$(realpath $f)" "$folder/$f"
                ;;
            *)
                ;;
        esac
    fi
done

