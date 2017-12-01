set number
set ruler

set tabstop=4
set shiftwidth=4
set expandtab

nnoremap <buffer> <leader>m :ProjectBuild<CR> :ProjectProblems<CR>
nnoremap <buffer> <leader>tt :JUnit<CR> :redraw!<CR>
nnoremap <buffer> <leader>tf :JUnit %<CR> :redraw!<CR>
nnoremap <buffer> <leader>ta :JUnit *<CR> :redraw!<CR>
nnoremap <buffer> <leader>ts :JUnitFindTest<CR>
nnoremap <silent> <buffer> <cr> :JavaSearchContext -a edit<cr>
nnoremap <silent> <buffer> <leader>fu :JavaSearch -a edit -x references<cr>
nnoremap <silent> <buffer> <leader>c :JavaCorrect<cr>
nnoremap <silent> <buffer> <leader>d :JavaDocComment<cr>
nnoremap <buffer> <leader>fn :JavaSearch -a edit
nnoremap <silent> <buffer> <leader>fi :JavaImport<cr>
nnoremap <silent> <buffer> <leader>fx :JavaImportOrganize<cr>

function! BuildGradle() abort
	:compiler gradle
	:make build
endfunction

function! TestGradle() abort
	:compiler gradle
	:make test
endfunction
