#!/bin/bash

FOLDERS+=(
        "$tmpInstallBackup"
        )



if [ ${#DEPENDENCIES[@]} -ne 0 ]; then
    dpkg -s "${DEPENDENCIES[@]}" > /dev/null
fi

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

