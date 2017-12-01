setl expandtab
setl shiftwidth=2
setl tabstop=2
setl number
nnoremap <buffer> <localleader>ff :%!jq .<CR>
nnoremap <buffer> <localleader>fu :%!jq -c .<CR>
