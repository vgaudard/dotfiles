scriptencoding utf-8
set nocompatible

"################################################################################
"############################### Vundle plugins #################################
"################################################################################
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
    "Plugin 'Valloric/YouCompleteMe'

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
    let g:ctrlp_map = '<Leader>o'

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
    " {{{
    let g:gitgutter_enabled = 0
    let g:gitgutter_map_keys = 0
    " }}}

    " Vim plugin for intensely orgasmic commenting
    Plugin 'scrooloose/nerdcommenter'

    " Vim omnicompletion (intellisense) and more for c#
    "Plugin 'OmniSharp/Omnisharp-vim'

    " dispatch.vim: asynchronous build and test dispatcher
    Plugin 'tpope/vim-dispatch'

    " Vim plugin that provides additional text objects
    Plugin 'wellle/targets.vim'

    " Hard Mode is a plugin which disables the arrow keys, the hjkl keys, the page up/down keys, and a handful of other keys which allow one to rely on character-wise navigation.
    "Plugin 'wikitopian/hardmode'
    " {{{
    "augroup cancer_mode
        "autocmd!
        "autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
        "autocmd VimEnter,BufNewFile,BufReadPost * nnoremap <leader>bh <Esc>:call ToggleHardMode()<Return>
    "augroup end
    " }}}

    " Plugin to help you stop repeating the basic movement keys 
    Plugin 'takac/vim-hardtime'
    augroup cancer_mode
        autocmd!
        autocmd VimEnter,BufNewFile,BufReadPost * silent! HardTimeOn
        autocmd VimEnter,BufNewFile,BufReadPost * nnoremap <leader>bh :HardTimeToggle<Return>
    augroup end

    " A Vim color scheme. http://stevelosh.com/projects/badwolf/
    Plugin 'sjl/badwolf'

    call vundle#end()
    filetype plugin indent on
endif
" }}}

"################################################################################
"############################### Appearance #####################################
"################################################################################
" {{{
" Gui options
if has("gui_running")
    set guifont=Ubuntu\ Mono\ derivative\ Powerline\ Regular
    set guifontwide=Ubuntu\ Mono\ derivative\ Powerline\ Bold
    set toolbar=
    set guioptions-=T
    set guioptions-=m
    set guioptions-=r
    set guioptions-=R
    set guioptions-=l
    set guioptions-=L
    au GUIEnter * call system('wmctrl -i -b add,maximized_vert,maximized_horz -r '.v:windowid)
endif

" Colorscheme
colorscheme badwolf

" }}}

"################################################################################
"############################### Vim commands ###################################
"################################################################################
" {{{

set showcmd		    " Show (partial) command in status line.
set autowrite		" Automatically save before commands like :next and :make
set hidden		    " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)
set textwidth=0
syntax on

" Search options
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set hlsearch		" Highlight search results

" Indenting options
set tabstop=4
set shiftwidth=4    " Number of spaces to use for each step of (auto)indent
set softtabstop=4
set smarttab
set expandtab
set autoindent
set shiftround      " Round indent to multiple of 'shiftwidth'

" Completion
set infercase

" Vim file management
set backup		" keep a backup file (restore to previous version)
set undofile		" keep an undo file (undo changes after closing)
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

"#### Remapping for an AZERTY keyboard
nnoremap ù .
nnoremap é ~
vnoremap é ~
nnoremap à @
nnoremap àà @@
vnoremap à @
vnoremap àà @@
nnoremap ' `
vnoremap ' `

" }}}

"################################################################################
"############################### Shortcuts ######################################
"################################################################################
" {{{
" Leader keys
" {{{
let mapleader="\<Space>"
let maplocalleader="è"
" }}}

"###############################
"######## Navigation ###########
"###############################
" {{{
" Window navigation
" {{{
nnoremap <Leader>h        <c-w>h
nnoremap <Leader>j        <c-w>j
nnoremap <Leader>k        <c-w>k
nnoremap <Leader>l        <c-w>l
nnoremap <Leader>H        <c-w>H
nnoremap <Leader>J        <c-w>J
nnoremap <Leader>K        <c-w>K
nnoremap <Leader>L        <c-w>L

" Taglist
nnoremap <Leader>t  :TlistToggle<Return>

" }}}

" Buffer navigation
" {{{
" Navigate in virtual line (j means the character below and not the line below)
nnoremap j gj
vnoremap j gj
onoremap j gj
nnoremap k gk
vnoremap k gk
onoremap k gk
" }}}

"  Quickfix
" {{{
nnoremap <Leader>fn     :cnext<Return>
nnoremap <Leader>fp     :cprevious<Return>
nnoremap <Leader>fc     :cclose<Return>
nnoremap <Leader>fo     :copen<Return>
nnoremap <Leader>ff     :call <SID>QuickfixToggle()<Return>

let g:quickfix_is_open = 0
function! s:QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunction
" }}}
" }}}

"###############################
"####### Mode management #######
"###############################
" {{{
" Quit insert mode when `jk` pressed
inoremap jk <Esc>
" }}}

"###############################
"####### File management #######
"###############################
" {{{
" Leader commands for writing and quitting
" {{{
nnoremap <silent>  <Leader>w   :update<Return>
nnoremap <silent>  <Leader>ww  :update<Return>
nnoremap <silent>  <Leader>wa  :wall<Return>
nnoremap <silent>  <Leader>q   :q<Return>
nnoremap <silent>  <Leader>wq  :exit<Return>
" }}}

" Quick edit files
" {{{
" {{{
nnoremap <Leader>ee  :vnew<Return>
nnoremap <Leader>e<Space>  :vsplit<Return>
nnoremap <Leader>ev  :vsplit $MYVIMRC<Return>
nnoremap <Leader>eb  :vsplit $HOME/.bashrc<Return>
nnoremap <Leader>ea  :vsplit $HOME/.bash_aliases<Return>
nnoremap <Leader>Ee  :new<Return>
nnoremap <Leader>EE  :new<Return>
nnoremap <Leader>E<Space>  :split<Return>
nnoremap <Leader>Ev  :split $MYVIMRC<Return>
nnoremap <Leader>Eb  :split $HOME/.bashrc<Return>
nnoremap <Leader>Ea  :split $HOME/.bash_aliases<Return>
"nnoremap <Leader>et  :silent !todo<Space>
function! EditTodo ()
    let l:todoArguments = input("!todo ")
    let l:systemRet = system("todo ".todoArguments)
    if strlen(l:systemRet) != 0
        echo "\n".l:systemRet
    endif
endfunction
nnoremap <silent> <Leader>et  :call EditTodo()<Return>
" }}}

" {{{
" Quick source files
nnoremap <Leader>rv  :source $MYVIMRC<Return>
nnoremap <Leader>rt  :echo system("todo")<Return>
" Add an empty line
nnoremap <Leader><Return>  o<Esc>
" }}}
" }}}

" Jump to the last position when reopening a file
" {{{
augroup last_position
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup end
" }}}
" }}}

"###############################
"##### Quick exec shortcuts ####
"###############################
" {{{
" As a general rule :
" <Leader>xr :         Run
" <Leader>xc :         Compile
" <Leader>xi :         Interactive
" <Leader>xx :         make
" <Leader>xm* :        Make with a specific rule (* = any character, depending on the rule)

" Run last compiled
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
augroup end
" }}}

" Python
" {{{
augroup exec_shortcut_python
    autocmd!
    autocmd FileType python     nnoremap <buffer>  <Leader>xr   :w\|!python %<Return>
    autocmd FileType python     nnoremap <buffer>  <Leader>xi   :w\|!python -i %<Return>
    autocmd FileType python     nnoremap <buffer>  <Leader>xtr  :w\|!python3 %<Return>
    autocmd FileType python     nnoremap <buffer>  <Leader>xti  :w\|!python3 -i %<Return>
augroup end
"}}}

" Caml
" {{{
augroup exec_shortcut_caml
    autocmd!
    autocmd FileType ocaml       nnoremap <buffer> <Leader>xr :w\|!ocaml %<Return>
    autocmd FileType ocaml       nnoremap <buffer> <Leader>xc :w\|!ocamlc %<Return>
    autocmd FileType ocaml       nnoremap <buffer> <Leader>xC :w\|!ocamlopt %<Return>
    " Maybe the compiling options are useless
augroup end
" }}}

" LaTeX
" {{{
augroup exec_shortcut_latex
    autocmd!
    autocmd FileType tex      nnoremap <buffer> <Leader>xl :w\|!latex %<Return>
    autocmd FileType tex      nnoremap <buffer> <Leader>xp :w\|!pdflatex %<Return>
    " Could not find how to specify a path
augroup end
" }}}

" C
" {{{
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
augroup end
" }}}

" C++
" {{{
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
augroup end
" }}}

" C#
" {{{
augroup exec_shortcut_csharp
    autocmd!
    autocmd FileType cs         nnoremap <buffer> <Leader>xc :wall \| !mcs %<Return>
    autocmd Filetype cs         nnoremap <buffer> <Leader>xr
                \ :execute "!".substitute(expand("%:p"), "\.cs$", ".exe", 0)
                \ <Return>
augroup end
" }}}

" JAVA
" {{{
augroup exec_shortcut_java
    autocmd!
    autocmd FileType java       nnoremap <buffer> <Leader>xc :w\|!javac %<Return>
    autocmd FileType java       nnoremap <buffer> <Leader>xr
                \ :w \|
                \ execute "!java ". substitute(expand("%"), ".java", "", "")
                \ <Return>
augroup end
" }}}

" Makefile
" {{{
nnoremap <Leader>xx :wall\|make<Return>
" }}}

" }}}

"###############################
"######## Clipboard ############
"###############################
" {{{
" Use leader for system clipboard
" {{{
nnoremap <Leader>y  "+y
nnoremap <Leader>d  "+d
vnoremap <Leader>y  "+y
vnoremap <Leader>d  "+d
nnoremap <Leader>p  "+p
nnoremap <Leader>P  "+P
vnoremap <Leader>p  "+p
vnoremap <Leader>P  "+P
" }}}

" Copy all buffer to system clipboard
nnoremap <Leader>v  ggvG$"+y''

" Expand on repeated v press
" {{{
vmap v      <Plug>(expand_region_expand)
vmap <C-v>  <Plug>(expand_region_shrink)
" Redraw vim
nnoremap <Leader>rr  :redraw!<Return>
" }}}
" }}}

"###############################
"####### Quick settings ########
"###############################
" {{{

" Toggle line numbers quickly
nnoremap <Leader>bn  :set number! relativenumber!<Return>

" Toggle line wrap
nnoremap <Leader>bw  :set wrap!<Return>

" Highlight trailing whitespaces
highlight TrailingWhitespace ctermbg=white guibg=white
nnoremap <Leader>bs  :match TrailingWhitespace /\s\+$/<Return>
nnoremap <Leader>bS  :match<Return>

" Remove highlight
nnoremap <Leader>bl :nohlsearch<Return>

" Target cursor
nnoremap <Leader>bt :set cursorline! cursorcolumn!<Return>

" Show defined folds
nnoremap <silent> <Leader>bz     :let &l:foldcolumn=4-&l:foldcolumn<Return>

" GitGutter
nnoremap <Leader>bg :GitGutterToggle<Return>

" }}}

"###############################
"####### Syntax check ##########
"###############################
" {{{
" Syntastic
nnoremap <Leader>s  :SyntasticCheck<Return>
" }}}

"###############################
"####### Text Formatting #######
"###############################
" {{{
" Tabular
" {{{
nnoremap <Leader>a=        :Tabularize /=<Return>
vnoremap <Leader>a=        :Tabularize /=<Return>
nnoremap <Leader>a:        :Tabularize /:\zs<Return>
vnoremap <Leader>a:        :Tabularize /:\zs<Return>
nnoremap <Leader>a<Space>  :Tabularize /<\S*\zs<Return>
vnoremap <Leader>a<Space>  :Tabularize /<\S*\zs<Return>
" }}}
" }}}

" }}}

"################################################################################
"############################### Abbreviations ##################################
"################################################################################
" {{{
" }}}

"################################################################################
"############################### Autocommands ###################################
"################################################################################
" {{{
"###############################
"##### Comments mappings #######
"###############################
" {{{
augroup comments_mapping
    autocmd!
    autocmd FileType c          nnoremap <buffer> <silent> <LocalLeader>c I/*<Esc>A*/<Esc>
    autocmd FileType cpp        nnoremap <buffer> <silent> <LocalLeader>c I//<Esc>
    autocmd FileType vim        nnoremap <buffer> <silent> <LocalLeader>c I"<Esc>
    autocmd FileType python     nnoremap <buffer> <silent> <LocalLeader>c I#<Esc>
    autocmd FileType javascript nnoremap <buffer> <silent> <LocalLeader>c I//<Esc>
augroup end
" }}}

"###############################
"### Filetype-specific edits ###
"###############################
" {{{
augroup markdown_shortcuts
    autocmd!
    " Underline current line with a line of =
    autocmd Filetype markdown   nnoremap <buffer> <LocalLeader>=     Yp0Vr=
augroup end

augroup semicolon_shortcuts
    autocmd!
    " Add a semicolon at the end of the line
    autocmd Filetype c,cpp,cs,java,javascript          nnoremap  <buffer>  <silent>  <LocalLeader>;  mqA;<esc>`q"<Return>
augroup end
" }}}

"###############################
"#### Most common structures ###
"###############################
" {{{
augroup shebang
    autocmd!
    autocmd FileType python     iabbrev <buffer> #! #!/usr/bin/env python
    autocmd FileType perl       iabbrev <buffer> #! #!/usr/bin/perl
    autocmd FileType ruby       iabbrev <buffer> #! #!/usr/bin/ruby
augroup end
" }}}

"###############################
"###### Specific movements  ####
"###############################
" {{{
" Markdown motions
" {{{
augroup movement_markdown
    autocmd!
    autocmd FileType markdown :onoremap ih :<c-u>execute  "normal! ?^\\(=\\\\|-\\)\\+$\r:nohlsearch\rkvg_"<cr>
    autocmd FileType markdown :onoremap ah :<c-u>execute  "normal! ?^\\(=\\\\|-\\)\\+$\r:nohlsearch\rg_vk0"<cr>
augroup end
" }}}
" }}}

"###############################
"####### Folding options #######
"###############################
" {{{
" Vim folds
" {{{
augroup folding_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup end
" }}}

" Curly braces folds
" {{{
augroup folding_curly
    autocmd!
    autocmd Filetype c,cpp,java     setlocal foldmethod=marker foldmarker={,}
    autocmd Filetype c,cpp,java     let &foldlevel = max(map(range(1, line('$')), 'foldlevel(v:val)'))
augroup end
" }}}

" Indentation-based folds
" {{{
augroup folding_indent
    autocmd!
    autocmd Filetype python,ruby,perl       setlocal foldmethod=indent
    autocmd Filetype python,ruby,perl       let &foldlevel = max(map(range(1, line('$')), 'foldlevel(v:val)'))
augroup end
" }}}
" }}}

"###############################
"#### Auto-comment options #####
"###############################
" {{{
augroup autocomment_options
    autocmd!
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup end
" }}}
" }}}

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
augroup trainingcmd
    autocmd!
augroup end
" }}}

" See 'wikitopian/hardmode' above
