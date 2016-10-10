#!/bin/bash

SYMLINKS["vim/.vimrc"]=""

FOLDERS+=(
        "$HOME/.vim/backup"
        "$HOME/.vim/undo"
        "$HOME/.vim/swap"
        )

REPOS+=(
        ["https://github.com/VundleVim/Vundle.vim.git"]="$HOME/.vim/bundle/Vundle.vim"
        )

