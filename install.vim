#!/usr/bin/vim -u
if !isdirectory($HOME . "/.vim/bundle/Vundle.vim/")
    echom "Trying to download Vundle"
    !git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
endif
echom(system("!mkdir -p" . $HOME . "/.vim/backup"))
echom(system("!mkdir -p" . $HOME . "/.vim/undo"))
echom(system("!mkdir -p" . $HOME . "/.vim/swap"))
quit
