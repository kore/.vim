setlocal keywordprg=pman

nnoremap <buffer> <leader>a :! grep -n '^\s*public[^(]\+function' % \| sort -d<CR>

" Completion for PHP keywords
setlocal dictionary+=~/.vim/ftplugin/php/keywords.txt

" Completion types to use (current buffer, other window buffers, invisible
" buffers, included files and keywords)
setlocal complete=.,w,b,i,k
