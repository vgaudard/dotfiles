#!/usr/bin/vim -u
echom "Bonjour"
function! AutoGet()
    let s:autoget_getAll = 0
    let s:autoget_getNothing = 0
    let s:autoget_getVundle = 0
    let s:autoget_vundleNowInstalled = 0
    let s:autoget_getBadwolf = 0
    let s:autoget_promptAnswer = ""
    if isdirectory($HOME . "/.vim/bundle/Vundle.vim/") == 0
        echom "Would you like to fetch Vundle ? (y/n/a/q) :"
        let s:autoget_promptAnswer = nr2char(getchar())
        echom s:autoget_promptAnswer
        if s:autoget_promptAnswer ==? "a"
            let s:autoget_getAll = 1
        elseif s:autoget_promptAnswer ==? "y"
            let s:autoget_getVundle = 1
        elseif s:autoget_promptAnswer ==? "n"
            let s:autoget_getVundle = 0 " Does not change anything, but for clarity's sake
        elseif s:autoget_promptAnswer ==? "q"
            let s:autoget_getNothing = 1
        else
            echom "\nAutoget: Answer unknown. Skipping all autoget"
            s:autoget_getNothing = 1
        endif
    endif
    if (s:autoget_getAll == 0 || s:autoget_getNothing ==  1) && (filereadable($HOME."/.vim/colors/badwolf.vim") == 0)
        echom "Would you like to fetch badwolf colorscheme ? (y/n/a/q) :"
        let s:autoget_promptAnswer = nr2char(getchar())
        if s:autoget_promptAnswer ==? "a"
            let s:autoget_getAll = 1
        elseif s:autoget_promptAnswer ==? "y"
            let s:autoget_getBadwolf = 1
        elseif s:autoget_promptAnswer ==? "n"
            let s:autoget_getBadwolf = 0 " Does not change anything, but for clarity's sake
        elseif s:autoget_promptAnswer ==? "q"
            let s:autoget_getNothing = 1
        else
            echom "Autoget: Answer unknown. Skipping all autoget"
            let s:autoget_getNothing = 1
        endif
    endif
    if (s:autoget_getAll || s:autoget_getVundle) && (filereadable($HOME."/.vim/colors/badwolf.vim") == 0)
        echom "Trying to download Vundle"
        !git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
        let s:autoget_vundleNowInstalled = 1
    endif
    if (s:autoget_getAll || s:autoget_getBadwolf) && (filereadable($HOME."/.vim/colors/badwolf.vim") == 0)
        echom "Trying to download badwolf colorscheme"
        !wget -P $HOME"/.vim/colors/" "https://raw.githubusercontent.com/sjl/badwolf/master/colors/badwolf.vim"
    endif
    if s:autoget_vundleNowInstalled == 1
        " There are so many ways this could go wrong, let's not rush into it
        " Moreover, this shouldn't affect local variables,  but for safety reasons, let's put it last in auto-get
        call getchar("If this is not the first time you see this warning, kill the vim process and clean up your .vimrc.\nOtherwise just press <Return>")
        let s:autoget_currentlySourcing = 1
        " We check above if this variable is set.
        " Thus, theoretically, this should only source the Vundle part
        source $MYVIMRC
        unlet s:autoget_currentlySourcing
        PluginInstall
    endif
    unlet s:autoget_getAll
    unlet s:autoget_getNothing
    unlet s:autoget_getVundle
    unlet s:autoget_vundleNowInstalled
    unlet s:autoget_getBadwolf
    unlet s:autoget_promptAnswer
endfunction
call AutoGet()
quit
