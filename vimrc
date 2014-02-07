set nocompatible               " be iMproved
filetype off                   " required!


" Init Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" "Sensible" defaults?
Bundle "tpope/vim-sensible"
" Display trailing whitespaces
Bundle 'jakobwesthoff/whitespacetrail'
" Fancy snippet machine
Bundle 'SirVer/ultisnips'
" Nice title bar
Bundle 'Lokaltog/powerline'
" Syntaxt checks
Bundle 'scrooloose/syntastic'
" Abbreviate and convenient substitute
Bundle 'tpope/vim-abolish'
" Solarized color scheme
Bundle "altercation/vim-colors-solarized"
" :Rename command and more shell commands
Bundle "tpope/vim-eunuch"
" XML editing
Bundle "sukima/xmledit"
" Insert mode autocomplete management
Bundle "ervandew/supertab"

" Elixir syntax highlighting
Bundle "elixir-lang/vim-elixir"

" Testing framework for VIM scripts
Bundle "runVimTests"

" PHP Documenting Bundle
Bundle "tobyS/pdv"

" Provides file skeletons
Bundle "tobyS/vmustache"
Bundle "tobyS/skeletons.vim"

" RST heading management
Bundle "tobyS/rst-headings.vim"

" Refactoring tool support
Bundle 'tomphp/vim-php-refactoring'

" Required after Vundle did its job.
filetype plugin indent on     " required!

" Automatically reload .vimrc if it is change
if has("autocmd")
    autocmd bufwritepost .vimrc source $MYVIMRC
endif

" Set numbers, sort casing, tabstops and such
set number
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set nocompatible
set nopaste
set nohidden
set nowrap

" Be case insensitive in searches
set ignorecase
" If upper case letters occur, be case insensitive
set smartcase
" Infer the current case in insert completion
set infercase

" Set the mapleader and local map leader to ,
let mapleader = ","
let maplocalleader = ","
set encoding=utf-8

" Automatic indention and such around expressions/brackets
set indentexpr=
set smartindent

" Do not highlight search results
set nohlsearch

" Jump 5 lines when running out of the screen
set scrolljump=5
" Indicate jump out of the screen when 3 lines before end of the screen
set scrolloff=3

" Set the autocomplete style for files
set wildmode=list:longest

" Cursor line in insert mode
autocmd InsertLeave * set nocursorline
autocmd InsertEnter * set cursorline

" Deactivate visual bell
set visualbell
set t_vb=
set ttyfast
set noruler
set laststatus=2

" Repair wired terminal/vim settings
set backspace=start,eol,indent
" ???
set ofu=syntaxcomplete#Complete
" Allow file inline modelines to provide settings
set modeline

" Set mapping for CSApprox
" let g:CSApprox_attr_map = { 'bold' : 'bold', 'italic' : '', 'sp' : '' }
" Set colors
set t_Co=256

syntax enable
" let g:solarized_termcolors=256
set background=light
colorscheme solarized

filetype plugin on
filetype indent on

" Restore line number and column if reentering a file after having edited it
" at least once. For this to work .viminfo in the home dir has to be writable by the user.
let g:restore_position_ignore = '.git/COMMIT_EDITMSG\|svn-commit.tmp'
au BufReadPost * call RestorePosition()

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
nnoremap <leader>L :set list!<CR>

" Save file as root using sudo
cnoremap w!! w !sudo tee % >/dev/null

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
autocmd InsertLeave <buffer> se nopaste

" Twig template highlighting
autocmd BufRead *.twig set filetype=twig
autocmd BufRead *.html.twig set filetype=htmltwig
" Handle *.phps as PHP files
au BufRead,BufNewFile *.phps		set filetype=php

" Undo history between sessions
set undodir=~/.vim/undodir
set undofile
set undolevels=100 "maximum number of changes that can be undone
set undoreload=1000 "maximum number lines to save for undo on a buffer reload

" Colored column (to see line size violations)
set colorcolumn=80

" Edit Files relativ to me
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" Enhance Omnicompletion
" http://vim.wikia.com/wiki/VimTip1386
set completeopt=longest,menuone

" Window Management
" TODO: Doesn't work?
nnoremap <C-j> <C-W>j
nnoremap <C-h> <C-W>h
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
nnoremap <C-0> <C-W>|
nnoremap <C-=> <C-W>=

" Map <F5> to turn spelling on (VIM 7.0+)
map <F5> :setlocal spell! spelllang=en_us<cr>
" Map <F6> to turn spelling (de) on (VIM 7.0+)
map <F6> :setlocal spell! spelllang=de<cr>

" Exclude from Pasta
let g:pasta_disabled_filetypes = ["tex"]

python from powerline.bindings.vim import source_plugin; source_plugin()

" Configure Ultisnips
let g:UltiSnipsExpandTrigger = "<Tab>"
let g:UltiSnipsListSnippets = "<M-Tab>"
" Set a custom snippets directory
let g:UltiSnipsSnippetsDir = $HOME . "/.vim/snippets/"
let g:UltiSnipsSnippetDirectories = ["snippets"]

" Configure PDV
let g:pdv_template_dir = $HOME . "/.vim/config/pdv/templates"
nnoremap <C-p> :call pdv#DocumentWithSnip()<CR>

" Remap leader for easy motion
let g:EasyMotion_leader_key = '<Leader>'

" Disable w3 syntax chcker. Horribly annoying on slow connections
let g:syntastic_html_checkers=['tidy']

" Completion options
set completeopt=menu,preview
" Default completion is "normal" (what my old PHP FT plugin did)
let g:SuperTabDefaultCompletionType = "<c-p>"
