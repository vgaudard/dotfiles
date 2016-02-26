scriptencoding utf-8


 "################################################################################
 "############################### Vundle plugins #################################
 "################################################################################
 " ======= VUNDLE BEGIN ========
 " {{{
if isdirectory($HOME . "/.vim/bundle/Vundle.vim/")
    set nocompatible
    filetype off

    " set the runtime path to include Vundle and initialize
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    " let Vundle manage Vundle, required
    Plugin 'VundleVim/Vundle.vim'

    " Surround.vim is all about "surroundings": parentheses, brackets, quotes, XML tags, and more.
    Plugin 'tpope/vim-surround'

    " Lean & mean status/tabline for vim that's light as air.
    Plugin 'bling/vim-airline'
    " {{{
    set laststatus=2
    let g:airline_powerline_fonts = 1
    let g:airline#extensions#csv#enabled = 1
    let g:airline#extensions#csv#column_display = 'Name'
    let g:airline#extensions#ctrlp#show_adjacent_modes = 1
    " }}}


    " Syntastic is a syntax checking plugin for Vim that runs files through
    " external syntax checkers and displays any resulting errors to the user.
    " To add syntax checkers: https://github.com/scrooloose/syntastic/wiki/Syntax-Checkers
    Plugin 'scrooloose/syntastic'
    " {{{
    let g:syntastic_html_checkers = ['w3'] " w3
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    "let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0
    let g:syntastic_echo_current_error = 1
     " HTML5.vim setup
    let g:html5_event_handler_attributes_complete = 0
    let g:html5_rdfa_attributes_complete = 0
    let g:html5_microdata_attributes_complete = 0
    let g:html5_aria_attributes_complete = 0
    let g:syntastic_python_python_exec = '/usr/bin/python3'
    " }}}

    " The "Tag List" plugin is a source code browser plugin for Vim and
    " provides an overview of the structure of source code files and allows
    " you to efficiently browse through source code files for different
    " programming languages.
    Plugin 'taglist.vim'

    " YouCompleteMe is a fast, as-you-type, fuzzy-search code completion
    " engine for Vim.
    Plugin 'Valloric/YouCompleteMe'

    " Indent Guides is a plugin for visually displaying indent levels in
    " Vim.
    Plugin 'nathanaelkane/vim-indent-guides'

    " endwise.vim is a simple plugin that helps to end certain
    " structures automatically
    Plugin 'tpope/vim-endwise'

    " I'm not going to lie to you; fugitive.vim may very well be the best
    " Git wrapper of all time. Check out these features:
    Plugin 'tpope/vim-fugitive'

    " vim-expand-region is a Vim plugin that allows you to visually select
    " increasingly larger regions of text using the same key combination
    Plugin 'terryma/vim-expand-region'

    " Full path fuzzy file, buffer, mru, tag, ... finder for Vim.
    Plugin 'ctrlpvim/ctrlp.vim'

    " A small Vim plugin for previewing markdown files in a browser.
    Plugin 'JamshedVesuna/vim-markdown-preview'

    " A Filetype plugin for csv files
    Plugin 'chrisbra/csv.vim'

    " Vim script for text filtering and alignment
    Plugin 'godlygeek/tabular'

    " A Vim plugin for focussing on a selected region
    Plugin 'chrisbra/NrrwRgn'

    " Vim-CtrlSpace, a comprehensive solution for your Vim editor providing
    Plugin 'vim-ctrlspace/vim-ctrlspace'

    " A Vim plugin which shows a git diff in the gutter (sign column) and stages/reverts hunks.
    Plugin 'airblade/vim-gitgutter'
    let g:gitgutter_enabled = 0
    let g:gitgutter_map_keys = 0

    " Vim plugin for intensely orgasmic commenting
    Plugin 'scrooloose/nerdcommenter'

    " Vim omnicompletion (intellisense) and more for c#
    Plugin 'OmniSharp/Omnisharp-vim'

    " dispatch.vim: asynchronous build and test dispatcher
    Plugin 'tpope/vim-dispatch'

    call vundle#end()
    filetype plugin indent on
endif
 " ============ VUNDLE END ==========
 " }}}

 "################################################################################
 "######################## Auto-get configuration files ##########################
 "################################################################################
 " {{{
if exists("s:autoget_currentlySourcing")
    " Stop processing the file, we only needed the Vundle part
    finish
endif
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
augroup autoget_cmd
    autocmd!
    autocmd VimEnter * call AutoGet()
augroup END
 " }}}

 "################################################################################
 "############################### Initialization #################################
 "################################################################################
 " {{{

augroup initialization_commands
    autocmd!
 " Jump to the last position when reopening a file
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup end

 " Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif




 " }}}


 "################################################################################
 "############################### Appearance #####################################
 "################################################################################

 " Colorscheme
colorscheme badwolf


 "################################################################################
 "############################### Vim commands ###################################
 "################################################################################
 " {{{

set showcmd		    " Show (partial) command in status line.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden		    " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)
set tabstop=4
set shiftwidth=4    " Number of spaces to use for each step of (auto)indent
set softtabstop=4
set smarttab
set expandtab
set autoindent
set shiftround      " Round indent to multiple of 'shiftwidth'
set textwidth=0
syntax on

set nocompatible

if has("vms")
    set nobackup		" do not keep a backup file, use versions instead
else
    set backup		" keep a backup file (restore to previous version)
    set undofile		" keep an undo file (undo changes after closing)
endif

 " #### Remapping for an AZERTY
nnoremap ù .
nnoremap é ~
vnoremap é ~
nnoremap à @
vnoremap à @

 " Go to end of pasted text
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

 " }}}


 "################################################################################
 "############################### Shortcuts ######################################
 "################################################################################

 " Leader keys
let mapleader="\<Space>"
let maplocalleader="è"

 " ########################################
 " ########## Window navigation ###########
 " ########################################
 " {{{
nnoremap <c-h>            <c-w>h
nnoremap <c-j>            <c-w>j
nnoremap <c-k>            <c-w>k
nnoremap <c-l>            <c-w>l
nnoremap <Leader>h        <c-w>h
nnoremap <Leader>j        <c-w>j
nnoremap <Leader>k        <c-w>k
nnoremap <Leader>l        <c-w>l
nnoremap <Leader>H        <c-w>H
nnoremap <Leader>J        <c-w>J
nnoremap <Leader>K        <c-w>K
nnoremap <Leader>L        <c-w>L

 " }}}




 " ########################################
 " ########## Quick exec shortcuts ########
 " ########################################

 " As a general rule :
 " <Leader>xr :         Run
 " <Leader>xc :         Compile
 " <Leader>xi :         Interactive
 " <Leader>xx :         make
 " <Leader>xm* :        Make with a specific rule (* = any character, depending on the rule)

 " {{{
if exists("*SetExecFilename") == 0
    function SetExecFilename (name)
        let b:runLastCompiled_userSetFilename = 1
        let b:runLastCompiled_execFilename = a:name
    endfunction
endif

if exists("*RunLastCompiled_GetExecFilename") == 0
    function RunLastCompiled_GetExecFilename ()
        if b:runLastCompiled_userSetFilename == 0
            "let b:runLastCompiled_execFilename=g:runLastCompiled_quickExecFolder."/"
            let b:runLastCompiled_execFilename=expand("%:p")
            let b:runLastCompiled_execFilename.=".out"
        endif
    endfunction
endif


augroup runLastCompiledCmds
    autocmd!
    autocmd BufRead,BufNewFile * let b:runLastCompiled_userSetFilename=0
    autocmd BufRead,BufNewFile * let b:runLastCompiled_execFilename=""
    let g:runLastCompiled_quickExecFolder = "/tmp"
augroup END

 " Python
augroup exec_shortcut_python
    autocmd!
    autocmd FileType python     nnoremap <buffer>  <Leader>xr   :w\|!python %<Return>
    autocmd FileType python     nnoremap <buffer>  <Leader>xi   :w\|!python -i %<Return>
    autocmd FileType python     nnoremap <buffer>  <Leader>xtr  :w\|!python3 %<Return>
    autocmd FileType python     nnoremap <buffer>  <Leader>xti  :w\|!python3 -i %<Return>
augroup END

 " Caml
augroup exec_shortcut_caml
    autocmd!
    autocmd FileType ocaml       nnoremap <buffer> <Leader>xr :w\|!ocaml %<Return>
    autocmd FileType ocaml       nnoremap <buffer> <Leader>xc :w\|!ocamlc %<Return>
    autocmd FileType ocaml       nnoremap <buffer> <Leader>xC :w\|!ocamlopt %<Return>
    " Maybe the compiling options are useless
augroup end

 " LaTeX
augroup exec_shortcut_latex
    autocmd!
    autocmd FileType tex      nnoremap <buffer> <Leader>xl :w\|!latex %<Return>
    autocmd FileType tex      nnoremap <buffer> <Leader>xp :w\|!pdflatex %<Return>
    " Could not find how to specify a path
augroup END

 " C
augroup exec_shortcut_c
    autocmd!
    autocmd FileType c          nnoremap <buffer> <Leader>xc
                \ :w\|
                \ call RunLastCompiled_GetExecFilename() \|
                \ execute "!gcc % -o " . b:runLastCompiled_execFilename
                \ <Return>
    autocmd Filetype c          nnoremap <buffer> <Leader>xr
                \ execute "!".b:runLastCompiled_execFilename()  \|
                \ <Return>
augroup END

 " C++
augroup exec_shortcut_cpp
    autocmd!
    autocmd FileType cpp        nnoremap <buffer> <Leader>xc
                \ :w\|
                \ call RunLastCompiled_GetExecFilename() \|
                \ execute "!g++ % -o " . b:runLastCompiled_execFilename
                \ <Return>
    autocmd Filetype cpp        nnoremap <buffer> <Leader>xr
                \ execute "!".b:runLastCompiled_execFilename  \|
                \ <Return>
augroup END

 " C#
augroup exec_shortcut_csharp
    autocmd!
    autocmd FileType cs         nnoremap <buffer> <Leader>xc :wall \| !mcs %<Return>
    autocmd Filetype cs         nnoremap <buffer> <Leader>xr
                \ :execute "!".substitute(expand("%:p"), "\.cs$", ".exe", 0)
                \ <Return>
augroup END

 " JAVA
augroup exec_shortcut_java
    autocmd!
    autocmd FileType java       nnoremap <buffer> <Leader>xc :w\|!javac %<Return>
    autocmd FileType java       nnoremap <buffer> <Leader>xr
                \ :w \|
                \ execute "!java ". substitute(expand("%"), ".java", "", "")
                \ <Return>
augroup END

 " Makefile
nnoremap <Leader>xx :wall\|make<Return>


 " }}}


 " ###############################
 " ###### Random shortcuts #######
 " ###############################
 " {{{

 " Navigate in virtual line (j means the character below and not the line below)
nnoremap j gj
vnoremap j gj
onoremap j gj
nnoremap k gk
vnoremap k gk
onoremap k gk

 " Quit insert and visual mode when `jk` pressed
inoremap jk <Esc>

 " Leader commands for writing and quitting
nnoremap <silent>  <Leader>w   :update<Return>
nnoremap <silent>  <Leader>ww  :update<Return>
nnoremap <silent>  <Leader>q   :q<Return>
nnoremap <silent>  <Leader>wq  :exit<Return>

 " Use leader for system clipboard
nnoremap <Leader>y  "+y
nnoremap <Leader>d  "+d
vnoremap <Leader>y  "+y
vnoremap <Leader>d  "+d
nnoremap <Leader>p  "+p
nnoremap <Leader>P  "+P
vnoremap <Leader>p  "+p
vnoremap <Leader>P  "+P

 " Copy all buffer to system clipboard
nnoremap <Leader>v  ggvG$"+y''


 " Expand on repeated v press
vmap v      <Plug>(expand_region_expand)
vmap <C-v>  <Plug>(expand_region_shrink)


 " Press <c-U> to convert current word to uppercase/lowercase
inoremap <c-u> <c-o><Plug>(expand_region_expand)~
nnoremap <c-u> <Plug>(expand_region_expand)~

 " Easy file navigation
nnoremap <Return> G
nnoremap <Backspace> gg
onoremap <Return> G
onoremap <Backspace> gg

 " File management
nnoremap <Leader>o :CtrlP<Return>


 " Select pasted text
nnoremap gV `[v`]

 " Quick edit files
nnoremap <Leader>ee  :vnew<Return>
nnoremap <Leader>ev  :vsplit $MYVIMRC<Return>
nnoremap <Leader>eb  :vsplit $HOME/.bashrc<Return>
nnoremap <Leader>ea  :vsplit $HOME/.bash_aliases<Return>
"nnoremap <Leader>et  :silent !todo<Space>
function! EditTodo ()
    let l:todoArguments = input("!todo ")
    let l:systemRet = system("todo ".todoArguments)
    if strlen(l:systemRet) != 0
        echo "\n".l:systemRet
    endif
endfunction
nnoremap <silent> <Leader>et  :call EditTodo()<Return>

 " Quick source files
nnoremap <Leader>rv  :source $MYVIMRC<Return>
nnoremap <Leader>rt  :echo system("todo")<Return>

 " Toggle line numbers quickly
nnoremap <Leader>bn  :set number! relativenumber!<Return>

 " Toggle line wrap
nnoremap <Leader>bw  :set wrap!<Return>

 " Add an empty line
nnoremap <Leader><Return>  o<Esc>

 " Redraw vim
nnoremap <Leader>rr  :redraw!<Return>

 " }}}


 " ###############################
 " ####### Selections ############
 " ###############################
 " {{{

onoremap in( :<c-u>normal!  f(vi(<cr>
onoremap il( :<c-u>normal!  F)vi(<cr>
onoremap an( :<c-u>normal!  f(va(<cr>
onoremap al( :<c-u>normal!  F)va(<cr>

onoremap in{ :<c-u>normal!  /{vi{<cr>
onoremap il{ :<c-u>normal!  ?}vi{<cr>
onoremap an{ :<c-u>normal!  /{va{<cr>
onoremap al{ :<c-u>normal!  ?}va{<cr>

 " }}}
 " ###############################
 " ####### Plugin mappings #######
 " ###############################
 " {{{
 " Syntastic
nnoremap <c-s>      :SyntasticCheck<Return>
nnoremap <Leader>s  :SyntasticCheck<Return>

 " Taglist
nnoremap <Leader>t  :TlistToggle<Return>

 " Tabular
nnoremap <Leader>a=        :Tabularize /=<CR>
vnoremap <Leader>a=        :Tabularize /=<CR>
nnoremap <Leader>a:        :Tabularize /:\zs<CR>
vnoremap <Leader>a:        :Tabularize /:\zs<CR>
nnoremap <Leader>a<Space>  :Tabularize /<\S*\zs<CR>
vnoremap <Leader>a<Space>  :Tabularize /<\S*\zs<CR>

 " GitGutter
nnoremap <Leader>bg :GitGutterToggle<Return>

 " }}}


 "################################################################################
 "############################### Abbreviations ##################################
 "################################################################################
 " {{{

 " }}}


 "################################################################################
 "############################### Autocommands ###################################
 "################################################################################




 "################################################################################
 "############################### Comments mappings ##############################
 "################################################################################

 " {{{
augroup comments_mapping
    autocmd!
    autocmd FileType c          nnoremap <buffer> <silent> <LocalLeader>c I/*<Esc>A*/
    autocmd FileType cpp        nnoremap <buffer> <silent> <LocalLeader>c I//<Esc>
    autocmd FileType vim        nnoremap <buffer> <silent> <LocalLeader>c I"<Esc>
    autocmd FileType python     nnoremap <buffer> <silent> <LocalLeader>c I#<Esc>
    autocmd FileType javascript nnoremap <buffer> <silent> <LocalLeader>c I//<Esc>
augroup end

 " }}}


 "################################################################################
 "########################### Filetype-specific shortcuts ########################
 "################################################################################
 " {{{
augroup markdown_shortcuts
    autocmd!
    " Underline current line with a line of =
    autocmd Filetype markdown   nnoremap <buffer> <LocalLeader>=     Yp0Vr=
augroup END

augroup semicolon_shortcuts
    autocmd!
    " Add a semicolon at the end of the line
    autocmd Filetype c,cpp,cs,java,javascript          nnoremap  <buffer>  <silent>  <LocalLeader>;  mqA;<esc>`q"<Return>
augroup END
 " }}}

 " ###############################
 " #### Most common structures ###
 " ###############################
augroup structures_abbreviations
 " {{{
    autocmd!
    autocmd FileType c,cpp      iabbrev <buffer>  inc #include ><left>
    autocmd FileType c,cpp      iabbrev <buffer>  _main int main(int argc, char** argv) {<Return><Return>return 0;<Return>}<Return><Up><Up><Up><Up><End>
    autocmd FileType cpp        iabbrev <buffer>  cout std::cout
    autocmd FileType cpp        iabbrev <buffer>  cin std::cin
    autocmd FileType cpp        iabbrev <buffer>  endl std::endl

    autocmd FileType c,cpp                      iabbrev <buffer> switchh switch ) {<Return>default:<Return>break;<Return>}<Up><Up><Up><End><Left><Left><Left>
    autocmd FileType c,cpp,javascript,java      iabbrev <buffer> iff if ) {<Return>}<Up><End><Left><Left><Left>
    autocmd FileType c,cpp,javascript,java      iabbrev <buffer> whl while ) {<Return>}<Up><End><Left><Left><Left>
    autocmd FileType c,cpp,javascript,java      iabbrev <buffer> ffor for ) {<Return>}<Up><End><Left><Left><Left>

    autocmd FileType python     iabbrev <buffer> iff if: {<Return>}<Up><End><Left><Left><Left>


    autocmd FileType python     iabbrev <buffer> #! #!/usr/bin/env python
    autocmd FileType perl       iabbrev <buffer> #! #!/usr/bin/perl
    autocmd FileType ruby       iabbrev <buffer> #! #!/usr/bin/ruby

augroup end

 " }}}


 " ###############################
 " ###### Specific movements  ####
 " ###############################

augroup movement_markdown
 " {{{
    autocmd!
    autocmd FileType markdown :onoremap ih :<c-u>execute  "normal! ?^\\(=\\\\|-\\)\\+$\r:nohlsearch\rkvg_"<cr>
    autocmd FileType markdown :onoremap ah :<c-u>execute  "normal! ?^\\(=\\\\|-\\)\\+$\r:nohlsearch\rg_vk0"<cr>
augroup END
 " }}}

 " ###############################
 " ####### Folding options #######
 " ###############################

augroup folding_vim
 " {{{
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
 " }}}

augroup folding_curly
 " {{{
    autocmd!
    autocmd Filetype c,cpp,java     setlocal foldmethod=marker foldmarker={,}
    autocmd Filetype c,cpp,java     let &foldlevel = max(map(range(1, line('$')), 'foldlevel(v:val)'))

 " }}}
augroup END

augroup folding_indent
 " {{{
    autocmd!
    autocmd Filetype python,ruby,perl       setlocal foldmethod=indent
    autocmd Filetype python,ruby,perl       let &foldlevel = max(map(range(1, line('$')), 'foldlevel(v:val)'))

 " }}}
augroup END

 " Show defined folds
nnoremap <silent> <Leader>bz     :let &l:foldcolumn=4-&l:foldcolumn<Return>

 "################################################################################
 "############################### Vimrc conclusion ###############################
 "################################################################################
 " {{{

set secure
"echo "\"set secure\" is commented out"




 " }}}

 "################################################################################
 "############################### Training mappings ##############################
 "################################################################################
 " This section is also known as "FUCK YOU, YOU FUCKING KEYBOARD! I HATE YOU
 " AND I WILL KILL YOUR WHOLE FUCKING KEYBOARD FAMILY
 " {{{
inoremap <Esc> <c-o>:throw 'Use jk instead'<Return>
nnoremap . <c-o>:throw 'Use ù instead'<Return>


augroup trainingcmd
    autocmd!
    autocmd FileType c,cpp      iabbrev <buffer> include NOPE
    autocmd FileType c,cpp      iabbrev <buffer> main main NOPE

    autocmd FileType c,cpp                      iabbrev <buffer> switch switchaNOPE
    autocmd FileType c,cpp,javascript,java      iabbrev <buffer> if iffify
    autocmd FileType c,cpp,javascript,java      iabbrev <buffer> while wwwhhhiiillleee
    autocmd FileType c,cpp,javascript,java      iabbrev <buffer> for run, FORest, run

    autocmd FileType python     iabbrev <buffer> if iffify
augroup end

 " }}}









