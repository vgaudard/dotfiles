scriptencoding utf-8

"################################################################################
"############################### Vundle plugins #################################
"################################################################################
" {{{
if isdirectory($HOME . "/.vim/bundle/Vundle.vim/")
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

    " endwise.vim is a simple plugin that helps to end certain
    " structures automatically
    Plugin 'tpope/vim-endwise'

    " Vim script for text filtering and alignment
    Plugin 'godlygeek/tabular'

    " Vim plugin that provides additional text objects
    Plugin 'wellle/targets.vim'

    " Vim plugin that allows use of vifm as a file picker
    Plugin 'vifm/vifm.vim'

    " A Vim color scheme. http://stevelosh.com/projects/badwolf/
    Plugin 'sjl/badwolf'

    " This is a simple vim plugin that add tab complete and type complete in
    " less then 50 lines of code.
    Plugin 'maxboisvert/vim-simple-complete'

    " Markdown Vim Mode http://plasticboy.com/markdown-vim-mode/
    Plugin 'plasticboy/vim-markdown'

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
    set guioptions-=e
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
set mouse=a
set textwidth=0
syntax on
set modeline
set timeout
set timeoutlen=300
set backspace=2     " Backspace behaves in a sane way

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
set nojoinspaces

" Text-wrapping
set wrap
set breakindent
set breakindentopt=sbr
set showbreak=↪>\

" Line number
set relativenumber number

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
nnoremap <Leader>bg  :TlistToggle<Return>

" }}}

" Buffer navigation
" {{{
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

" Detach buffer to new tab
" {{{
nnoremap <Leader>t :tabedit % \| tabprevious \| close \| tabnext <Return>
" }}}
" }}}
" }}}

"###############################
"####### Mode management #######
"###############################
" {{{
" Quit insert mode when `jk` or `kj` pressed
inoremap jk <Esc>
inoremap kj <Esc>
augroup InsertTimeoutlen
    autocmd!
    autocmd InsertEnter * let old_timeoutlen = &timeoutlen | set timeoutlen=60
    autocmd InsertLeave * let &timeoutlen = old_timeoutlen | unlet old_timeoutlen
augroup end
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
nnoremap <silent>  <Leader>wn  :update<Return>:next<Return>
nnoremap <silent>  <Leader>wp  :update<Return>:previous<Return>
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

" }}}

"###############################
"####### Quick settings ########
"###############################
" {{{

" Toggle line numbers quickly
nnoremap <Leader>bn  :set number! relativenumber!<Return>

" Toggle line wrap
nnoremap <Leader>bw  :set wrap!<Return>

" Remove highlight
nnoremap <Leader>bl :nohlsearch<Return>

" Target cursor
nnoremap <Leader>bt :set cursorline! cursorcolumn!<Return>

" Show defined folds
nnoremap <silent> <Leader>bz     :let &l:foldcolumn=4-&l:foldcolumn<Return>

nnoremap <Leader>bs :SyntasticToggleMode

" GitGutter
nnoremap <Leader>gg :GitGutterSignsToggle<Return>
nnoremap <Leader>gh :GitGutterLineHighlightsEnable<Return>
nnoremap <Leader>gp <Plug>GitGutterPrevHunk<Return>
nnoremap <Leader>gn <Plug>GitGutterNextHunk<Return>
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
    autocmd FileType markdown :onoremap ih :<c-u>execute  "normal! ?^\\(=\\\\|-\\)\\+$\r:nohlsearch\rkvg_"<Return>
    autocmd FileType markdown :onoremap ah :<c-u>execute  "normal! ?^\\(=\\\\|-\\)\\+$\r:nohlsearch\rg_vk0"<Return>
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
    autocmd FileType vim setlocal foldmethod=marker foldmarker={{{,}}}
augroup end
" }}}

" {{{
augroup folding_mutt
    autocmd!
    autocmd FileType muttrc setlocal foldmethod=marker foldmarker={{{,}}}
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

"###############################
"#### Spelling #################
"###############################
" {{{
augroup filetype_spelling
    autocmd!
    autocmd FileType gitcommit setlocal spell spelllang=en
    autocmd FileType markdown setlocal spell spelllang=en,fr tw=80
augroup END
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
" }}}


