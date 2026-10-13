set nocompatible               " be iMproved
filetype off                   " required!

" Init Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" "Sensible" defaults
Bundle "tpope/vim-sensible"
" Abbreviate and convenient substitute
Bundle 'tpope/vim-abolish'

" Insert mode autocomplete management
Bundle "ervandew/supertab"

" Elixir syntax highlighting
Bundle "elixir-lang/vim-elixir"

" HLSL Syntax highlightinh
Bundle 'beyondmarc/hlsl.vim'

" Syntax and ftplugins for many languages
Bundle 'sheerun/vim-polyglot'

" Multichange
Bundle 'git@github.com:AndrewRadev/multichange.vim.git'

" Everforest theme
Bundle 'sainnhe/everforest'

" Git diff markers in the sign column (toggled on demand, see below)
Bundle 'airblade/vim-gitgutter'

" Disable polyglot JSX indentation which breaks indent in JavaScript files
let g:polyglot_disabled = ['jsx', 'php']

" Required after Vundle did its job.
filetype plugin indent on

" All autocommands below go into this group, so re-sourcing does not stack them
augroup vimrc
    autocmd!
augroup END

" Automatically reload vimrc when it is changed
autocmd vimrc BufWritePost .vimrc,vimrc source $MYVIMRC

"""""""""""""""""""
" Standard settings
"""""""""""""""""""

" Set numbers, sort casing, tabstops and such
set number
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set nopaste
set nohidden
set nowrap
set encoding=utf-8

" Necessary for Vundle to work
set shell=/run/current-system/sw/bin/bash

" Be case insensitive in searches
set ignorecase
" If upper case letters occur, be case insensitive
set smartcase
" Infer the current case in insert completion
set infercase

" Set the mapleader and local map leader to <space>
let mapleader = "\<Space>"
let maplocalleader = "\<Space>"

" Automatic indention and such around expressions/brackets
set indentexpr=
set smartindent

" Do not highlight search results
set nohlsearch

" Highlight extra spaces at the line ending (not while typing at the cursor).
" Defined on ColorScheme, as :colorscheme clears custom highlight groups.
autocmd vimrc ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd vimrc BufWinEnter,InsertLeave * match ExtraWhitespace /\s\+$/
autocmd vimrc InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/

" Jump 5 lines when running out of the screen
set scrolljump=5
" Indicate jump out of the screen when 3 lines before end of the screen
set scrolloff=3

" Set the autocomplete style for files
set wildmode=list:longest

" Cursor line in insert mode
autocmd vimrc InsertLeave * set nocursorline
autocmd vimrc InsertEnter * set cursorline

" Deactivate visual bell
set visualbell
set t_vb=
set noruler
set laststatus=2

" ???
set ofu=syntaxcomplete#Complete
" Allow file inline modelines to provide settings
set modeline

syntax enable

" Complete options (disable preview scratch window, longest removed to aways show menu)
set completeopt=menu,menuone
set formatoptions-=w

" Restore line number and column if reentering a file after having edited it
" at least once. For this to work .viminfo in the home dir has to be writable by the user.
let g:restore_position_ignore = '.git/COMMIT_EDITMSG\|svn-commit.tmp'
autocmd vimrc BufReadPost * call RestorePosition()

func! RestorePosition()
    if exists("g:restore_position_ignore") && match(expand("%"), g:restore_position_ignore) > -1
        return
    endif

    if line("'\"") > 1 && line("'\"") <= line("$")
        exe "normal! g`\""
    endif
endfunc

" Enable customized non-visible character display
" http://vimcasts.org/episodes/show-invisibles/
nnoremap <leader>l :set list!<CR>

" Save file as root using sudo
cnoremap w!! w !sudo tee % >/dev/null

" Alias common w/q misspells to their right meaning
command! WQ wq
command! Wq wq
command! W w
command! Q q

" MovingThroughCamelCaseWords
nnoremap <silent><C-Left>  :<C-u>cal search('\<\<Bar>\U\@<=\u\<Bar>\u\ze\%(\U\&\>\@!\)\<Bar>\%^','bW')<CR>
nnoremap <silent><C-Right> :<C-u>cal search('\<\<Bar>\U\@<=\u\<Bar>\u\ze\%(\U\&\>\@!\)\<Bar>\%$','W')<CR>
inoremap <silent><C-Left>  <C-o>:cal search('\<\<Bar>\U\@<=\u\<Bar>\u\ze\%(\U\&\>\@!\)\<Bar>\%^','bW')<CR>
inoremap <silent><C-Right> <C-o>:cal search('\<\<Bar>\U\@<=\u\<Bar>\u\ze\%(\U\&\>\@!\)\<Bar>\%$','W')<CR> 

" Toggle paste with <ins>
set pastetoggle=<ins>
" Go to insert mode when <ins> pressed in normal mode
nnoremap <silent> <ins> :setlocal paste!<CR>i
" Switch paste mode off whenever insert mode is left
autocmd vimrc InsertLeave * setlocal nopaste

" Handle *.phps as PHP files
autocmd vimrc BufRead,BufNewFile *.phps set filetype=php

" Undo history between sessions
set undodir=~/.vim/undodir
set undofile
set undolevels=100 "maximum number of changes that can be undone
set undoreload=1000 "maximum number lines to save for undo on a buffer reload

" Keep swap files out of ~/.vim (which is this repository)
if !isdirectory($HOME . '/.cache/vim/swap')
    call mkdir($HOME . '/.cache/vim/swap', 'p', 0700)
endif
set directory=~/.cache/vim/swap//

" Colored column (to see line size violations)
set colorcolumn=80

" Edit Files relativ to me
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" Map <F5> to turn spelling on (VIM 7.0+)
map <F5> :setlocal spell! spelllang=en_us<cr>
" Map <F6> to turn spelling (de) on (VIM 7.0+)
map <F6> :setlocal spell! spelllang=de<cr>

" Attempt to do semantic completion, then fall back to keywords
let g:SuperTabDefaultCompletionType = "context"

set wildignore+=cache,src/var,src/data,.abc,build

" Make moving in tabs more comfortable
nnoremap <leader>j :tabprevious<CR>
nnoremap <leader>k :tabnext<CR>
" Shift version moves current tab
nnoremap <leader><S-j> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <leader><S-k> :execute 'silent! tabmove ' . tabpagenr()<CR>

" Make moving page wise more comfortable
nnoremap <C-j> <C-f>
nnoremap <C-k> <C-b>

" y/p/d with system clipboard through leader
vmap <Leader>y "*y
vmap <Leader>d "*d
nmap <Leader>p "*p
nmap <Leader>P "*P
vmap <Leader>p "*p
vmap <Leader>P "*P

" Disable folding
set nofoldenable

" Set terminal title
set title

" Set Everforest theme
if has('termguicolors')
  set termguicolors
endif

set background=light
let g:everforest_background = 'hard'
let g:everforest_better_performance = 1

colorscheme everforest

" Git diff display: off by default, <leader>g toggles signs + line highlights
let g:gitgutter_enabled = 0
let g:gitgutter_highlight_lines = 1
set updatetime=250
nnoremap <silent> <leader>g :GitGutterToggle<CR>
" Jump between changed hunks
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
