#!/usr/bin/vim -u
let folders=[$HOME . "/.vim/backup",
             $HOME . "/.vim/undo",
             $HOME . "/.vim/swap",]
if !isdirectory($HOME . "/.vim/bundle/Vundle.vim/")
    echom "Trying to download Vundle"
    !git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
endif
for f in folders
    echom(system("!mkdir -p" . f))
endfor
quit
