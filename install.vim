#!/usr/bin/vim -u
if (s:autoget_getAll || s:autoget_getVundle)
    echom "Trying to download Vundle"
    !git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    let s:autoget_vundleNowInstalled = 1
endif
!mkdir $HOME . "/.vim/"
!mkdir $HOME . "/.vim/backup"
!mkdir $HOME . "/.vim/undo"
!mkdir $HOME . "/.vim/swap"
quit
