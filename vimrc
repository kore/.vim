set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=/usr/share/vim/addons

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
" Syntaxt checks
Bundle 'scrooloose/syntastic'
" Abbreviate and convenient substitute
Bundle 'tpope/vim-abolish'
" Solarized color scheme
Bundle "altercation/vim-colors-solarized"
" :Rename command and more shell commands
Bundle "tpope/vim-eunuch"

" Vmustache template engine, prerequisite for PDV
Bundle "tobyS/vmustache"
" PHP Documentor for VIM
Bundle "tobyS/pdv"
" New file skeletons
Bundle "tobyS/skeletons.vim"
" Maintains RST headings
Bundle "tobyS/rst-headings.vim"

" Testing framework for VIM scripts
Bundle "inkarkat/runVimTests"

" Pasting Gists from VIM
Bundle 'mattn/webapi-vim'
Bundle 'mattn/gist-vim'

" Insert mode autocomplete management
Bundle "ervandew/supertab"

" Elixir syntax highlighting
Bundle "elixir-lang/vim-elixir"

" Syntax and ftplugins for many languages
Bundle 'sheerun/vim-polyglot'

" Syntax and ftplugins for many languages
Bundle 'Valloric/YouCompleteMe'

" Refactoring tool support
Bundle 'tomphp/vim-php-refactoring'

" Multichange
Bundle 'git@github.com:AndrewRadev/multichange.vim.git'

" Disable polyglot JSX indentation which breaks indent in JavaScript files
let g:polyglot_disabled = ['jsx', 'php']

" Disable YouCompleteMe for PHP
"let g:ycm_filetype_blacklist = { 'php': 1 }

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"


" Required after Vundle did its job.
if has("autocmd")
    filetype plugin indent on
endif

" Automatically reload .vimrc if it is change
if has("autocmd")
    autocmd bufwritepost .vimrc source $MYVIMRC
endif

"""""""""""""""""""
" Standard settings
"""""""""""""""""""

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
set encoding=utf-8

" Necessary for Vundle to work
set shell=/bin/bash

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

" Highlight extra spaces at the line ending
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()


" Jump 5 lines when running out of the screen
set scrolljump=5
" Indicate jump out of the screen when 3 lines before end of the screen
set scrolloff=3

" Set the autocomplete style for files
set wildmode=list:longest

" Deactivate original mode indicator, powerline does that
set noshowmode

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

" Complete options (disable preview scratch window, longest removed to aways show menu)
set completeopt=menu,menuone

set formatoptions-=w

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
nnoremap <leader>l :set list!<CR>

" Save file as root using sudo
cnoremap w!! w !sudo tee % >/dev/null

" Alias common w/q misspells to their right meaning
command WQ wq
command Wq wq
command W w
command Q q

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
autocmd InsertLeave <buffer> setlocal nopaste

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

" Map <F5> to turn spelling on (VIM 7.0+)
map <F5> :setlocal spell! spelllang=en_us<cr>
" Map <F6> to turn spelling (de) on (VIM 7.0+)
map <F6> :setlocal spell! spelllang=de<cr>

" Exclude from Pasta
let g:pasta_disabled_filetypes = ["tex"]

" python from powerline.bindings.vim import source_plugin; source_plugin()

" Configure Ultisnips
let g:UltiSnipsExpandTrigger = "<Tab>"
let g:UltiSnipsListSnippets = "<M-Tab>"
" Set a custom snippets directory
let g:UltiSnipsSnippetsDir = $HOME . "/.vim/ultisnips/"
let g:UltiSnipsSnippetDirectories = ["ultisnips"]

" Configure PDV
let g:pdv_template_dir = $HOME . "/.vim/config/pdv/templates"
nnoremap <C-p> :call pdv#DocumentWithSnip()<CR>

" Remap leader for easy motion
let g:EasyMotion_leader_key = '<Leader>'

" Disable HTML syntax checks. Horribly slow & annoying
"let g:syntastic_debug=63
let g:syntastic_ignore_extensions='\c\v^([gx]?z|lzma|html|bz2)$'

" Attempt to do semantic completion, then fall back to keywords
let g:SuperTabDefaultCompletionType = "context"

" Post private Gists by default
let g:gist_post_private = 1

" <C-P> is already PDV so <leader>o is used for CtrlP file finder
let g:ctrlp_map = "<leader>o"
" Use regex search in CtrlP by default (switch off, we want to use fuzzzzy!)
" let g:ctrlp_regexp = 1
set wildignore+=cache,src/var,src/data,.abc,build
" Ignore VCS dirs (copied from docs)
let g:ctrlp_custom_ignore = '\v[\/](\.(git|hg|svn)|vendor)$'
" I want to search the current working dir only
let g:ctrlp_working_path_mode = ''

" Make moving in tabs more comfortable
nnoremap <leader>j :tabprevious<CR>
nnoremap <leader>k :tabnext<CR>
" Shift version moves current tab
nnoremap <leader><S-j> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <leader><S-k> :execute 'silent! tabmove ' . tabpagenr()<CR>

" Make moving page wise more comfortable
nnoremap <C-j> <C-f>
nnoremap <C-k> <C-b>
" Jump to next/prev start of method
nnoremap <C-m> ]m
nnoremap <C-S-m> [m

" Activate argument rewrap
nnoremap <leader>w :call argumentrewrap#RewrapArguments()<CR>

" Expand region with v-v-v...
vmap v <Plug>(expand_region_expand)
vmap <S-v> <Plug>(expand_region_shrink)

" PHP expand objects
let g:expand_region_text_objects_php = {
    \ 'iw'  :0,
    \ 'i"'  :0,
    \ 'i''' :0,
    \ 'i]'  :1,
    \ 'ia'  :0,
    \ 'aa'  :0,
    \ 'i)'  :1,
    \ 'a)'  :1,
    \ 'i}'  :1,
    \ 'a}'  :1
    \ }

" y/p/d with system clipboard through leader
vmap <Leader>y "*y
vmap <Leader>d "*d
nmap <Leader>p "*p
nmap <Leader>P "*P
vmap <Leader>p "*p
vmap <Leader>P "*P

" Argument move & argument text object
nnoremap <c-h> :SidewaysLeft<cr>
nnoremap <c-l> :SidewaysRight<cr>

omap aa <Plug>SidewaysArgumentTextobjA
xmap aa <Plug>SidewaysArgumentTextobjA
omap ia <Plug>SidewaysArgumentTextobjI
xmap ia <Plug>SidewaysArgumentTextobjI

" Disable folding
set nofoldenable

" Set terminal title
set title
