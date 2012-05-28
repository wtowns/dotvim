" Vim settings for 'php' filetypes
" Maintainer:	William Towns <wtowns@gmail.com>
"
" To use it, copy it to: ~/vim/ftplugin/php.vim
"
" Layout  ----------------------------------------------------------- {{{

setlocal number

" }}}
" Compilation ----------------------------------------------------------- {{{

setlocal makeprg=php\ -l\ %
setlocal errorformat=%m\ in\ %f\ on\ line\ %l
let php_folding = 1

" }}}
" Tags ----------------------------------------------------------- {{{

" Look for tags file up to /
:set tags=tags;/

nmap <buffer><silent> <F4>
	\ :!ctags -f ./tags
	\ --langmap="php:+.inc"
	\ -h ".php.inc" -R --totals=yes
	\ --tag-relative=yes --PHP-kinds=+cf-v .<CR>

" }}}
" Taglist ----------------------------------------------------------- {{{

" Map taglist toggle and try not to confuse it with multiple open files
nnoremap <Leader>l :TlistToggle<CR>
let g:Tlist_Show_One_File=1
let g:Tlist_Exit_OnlyWindow=1
let tlist_php_settings = 'php;c:class;d:constant;f:function'

" }}}
