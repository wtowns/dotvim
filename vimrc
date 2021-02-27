" Vim user settings
" Maintainer:	William Towns <wtowns@gmail.com>
"
" To use it, copy/symlink it to
"              for *nix:  ~/.vimrc
"    for Windows (gVim):  $VIM\_vimrc

" Preamble ------------------------------------------------------------{{{

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

let g:goldenview__enable_default_mapping = 0

let g:pathogen_disabled = ['ctrlp.vim','omnisharp-vim','YouCompleteMe','ultisnips']

" pathogen-managed plugins, go!
call pathogen#infect()

"}}}
" Workarounds ---------------------------------------------------------{{{

" Screen defaults to 2 colors
if &term == "screen"
    set t_Co=256
endif

"}}}
" FileType Overrides --------------------------------------------------{{{

  augroup vimrcAutoExt
  au!

  autocmd BufRead,BufNewFile CMakeLists.txt setfiletype cmake
  autocmd BufRead,BufNewFile *.txt setfiletype text
  autocmd BufRead,BufNewFile *.as setfiletype actionscript
  autocmd BufRead,BufNewFile *.xmobarrc setfiletype haskell
  autocmd BufRead,BufNewFile *.pex setfiletype xml
  autocmd BufRead,BufNewFile *.jsfl setfiletype javascript
  autocmd BufRead,BufNewFile *.unity setfiletype yaml
  autocmd BufRead,BufNewFile *.prefab setfiletype yaml
  autocmd BufRead,BufNewFile *gitconfig* setfiletype gitconfig

  augroup END

"}}}
" Standard Options ----------------------------------------------------{{{

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup                  " do not keep a backup file, use versions instead
else
  set backup                    " keep a backup file
  set backupdir-=.              " do not save backups in current directory
  set backupdir^=$HOME/tmp      " put backups in $HOME/tmp directory
  set dir-=.                    " do not put swapfiles in current directory
  set dir^=$HOME/tmp            " put swapfiles in $HOME/tmp directory
endif
set history=50                  " keep 50 lines of command line history
set ruler                       " show the cursor position all the time
set showcmd                     " display incomplete commands
set incsearch                   " do incremental searching
set nowrap                      " don't wrap when reaching the right side of the screen
set ignorecase                  " ignore case when searching
set smartcase                   " ... except when we want it
set notitle                     " no 'thanks for flying vim'
set wildmenu                    " use the wildmenu for tab completion
set wildmode=longest:full,full  " first tab completes as much as possible; tabs after will cycle through options
set laststatus=2                " Always show status line
set cursorline                  " Show the cursorline
set scrolloff=3                 " Give three lines of top/bottom context in buffers
set hidden                      " Keep active buffer loaded when switching to a new one
set wildignore+=*/bin-debug/*
set clipboard=unnamed           " Use the system clipboard
set noshowmode                  " Don't show the mode in the status line (leave it up to powerline)

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Also switch on highlighting the last used search pattern.

if &t_Co > 2 || has("gui_running")
	" Switch syntax highlighting on, but only when the terminal has colors
	syntax on

	" Color scheme settings
	if has("gui_running")
		let g:jellybeans_overrides = {
		\	'Folded': { 'guifg': 'a0a8b0', 'guibg': 'Black', 'ctermfg': 'a0a8b0', 'ctermbg': 'Black', 'attr': 'italic' },
		\	'MatchParen': { 'guifg': 'ffffff', 'guibg': '000000', 'ctermfg': '', 'ctermbg': 'Black', 'attr': 'bold'}
		\}
	else
		let g:jellybeans_overrides = {
		\	'Folded': { 'guifg': 'a0a8b0', 'guibg': '', 'ctermfg': 'a0a8b0', 'ctermbg': '', 'attr': 'italic' },
		\	'MatchParen': { 'guifg': 'ffffff', 'guibg': '000000', 'ctermfg': '', 'ctermbg': 'Black', 'attr': 'bold'},
		\	'background': { 'guibg': '', 'ctermbg': '' }
		\}
	endif
	set background=dark
	silent! colorscheme jellybeans
	" This is overridden manually in jellybeans; fix it
	hi SpecialKey ctermbg=none
endif

" Preferred line endings
set fileformats=unix,dos,mac

" Special characters
set list
set listchars=
set listchars+=tab:·\ 
set listchars+=eol:¬

"}}}
" Plugin Options ------------------------------------------------------{{{

" Try turning off delimitmate
let delimitMate_offByDefault = 1

" Don't jump to the first item in cscope searches
let Cscope_JumpError = 0

" CtrlP mixed mode by default
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_mruf_relative = 1
" Default to filename mode
let g:ctrlp_by_filename = 1
" Use the silver searcher in CtrlP
if executable('ag')
	let g:ctrlp_user_command = {
	\ 'types': {
		\ 1: ['.git', 'cd %s && git ls-files; git submodule foreach "for file in $(git ls-files); do echo \"$path/$file\"; done"'],
		\ 2: ['.hg', 'hg --cwd %s locate -I .'],
		\ },
	\ 'fallback': 'find %s -type f'
	\ }

endif
" No limit to CtrlP file count
let g:ctrlp_max_files = 0
" Search from root project directory in CtrlP, starting from CWD; use CWD as
"  fallback
let g:ctrlp_working_path_mode = 'rwa'
" Keep the ctrlp cache between sessions
let g:ctrlp_clear_cache_on_exit = 0
" Increase window size
let g:ctrlp_max_height = 20
" Lazy update
let g:ctrlp_lazy_update=1
" Add tag search to CtrlP
let g:ctrlp_extensions = ['tag']

" Use OmniSharp for syntastic checkers
let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']

" Eclim
let g:EclimJavaImplInsertAtCursor = 1

" YouCompleteMe
let g:ycm_auto_trigger = 0 " Turn off the popup-as-you-type (feels slow to me)
"
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
"let g:UltiSnipsExpandTrigger = "<tab>"
"let g:UltiSnipsJumpForwardTrigger = "<tab>"
"let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

"}}}
" Autocommands --------------------------------------------------------{{{

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

"}}}
" Functions -----------------------------------------------------------{{{

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" copy to X11 PRIMARY buffer (middle-click to paste (shift+insert in terminal))
function! CopyToX11Primary() range
    echo system('echo '.shellescape(join(getline(a:firstline, a:lastline), "\n")).'| xsel -i')
endfunction

" Write to the Windows clipboard
function! Putclip(type, ...) range
	let sel_save = &selection
	let &selection = "inclusive"
	let reg_save = @@
	if a:type == 'n'
		silent exe a:firstline . "," . a:lastline . "y"
	elseif a:type == 'c'
		silent exe a:1 . "," . a:2 . "y"
	else
		silent exe "normal! `<" . a:type . "`>y"
	endif
	call writefile(split(@@,"\n"), '/dev/clipboard')
	let &selection = sel_save
	let @@ = reg_save
endfunction

function! NextSection(backwards, visual)
	if a:visual
		normal! gv
	endif

	if a:backwards
		let dir = '?'
	else
		let dir = '/'
	endif

	execute 'silent normal! ' . dir . '^\s*$' . "\r"
endfunction

command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
function! QuickfixFilenames()
	" Building a hash ensures we get each buffer only once
	let buffer_numbers = {}
	for quickfix_item in getqflist()
		let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
	endfor
	return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

"}}}
" Mappings ------------------------------------------------------------{{{

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" .vimrc editing/reloading shortcuts
:nnoremap <leader>vv :edit $MYVIMRC<cr>
:nnoremap <leader>vt :tabedit $MYVIMRC<cr>
:nnoremap <leader>vs :source $MYVIMRC<cr>

" turn off highlighting on return or double-leader
nnoremap <CR> :noh<CR><CR>
nnoremap <leader><leader> :noh<CR>

" Allow { and } to work with files edited by primitive editors
noremap <silent> } :call NextSection(0, 0)<cr>
noremap <silent> { :call NextSection(1, 0)<cr>
vnoremap <silent> } :<c-u>call NextSection(0, 1)<cr>
vnoremap <silent> { :<c-u>call NextSection(1, 1)<cr>

" j+k in insert mode == esc
inoremap jk <esc>
inoremap Jk <esc>
inoremap jK <esc>
inoremap JK <esc>

" j+k in command mode == esc, as well
cnoremap jk <esc>

" improve j and k when lines wrap
noremap j gj
noremap k gk

" don't clobber unnamed register when pasting in visual mode
vnoremap p pgvy

" search & replace
nnoremap <Leader>sr :%s/\<<C-r><C-w>\>/

" project Ack
if executable('ag')
	let g:ackprg = 'ag --nogroup --nocolor --column'
endif
nnoremap <Leader>gg :Ack! -i ''<Left>
nnoremap <Leader>gw :Ack! -i ''<Left><C-R><C-W><CR>

" copy to X11 clipboard
vnoremap <Leader>c :call CopyToX11Primary()<CR>

" copy to Windows clipboard
vnoremap <silent> <leader>y :call Putclip(visualmode(), 1)<CR>
nnoremap <silent> <leader>y :call Putclip('n', 1)<CR>

" windows
nnoremap <leader>a <c-w><c-w>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" tab shortcuts
nnoremap H :tabp<CR>
nnoremap L :tabn<CR>
nnoremap <Leader>n :tabe<CR>
if has("gui_running")
    map <C-tab> :tabn<CR>
    map <C-S-tab> :tabp<CR>
endif

" tags, files, and buffers

" go to tag in new tab
nnoremap <leader>g] :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

" quickfix
nnoremap <leader>co :copen<cr>
nnoremap <leader>cc :cclose<cr>

" Fugitive
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>go :only<cr>

nnoremap <c-p> :Files<cr>

" Make keypad work in Vim with iTerm on OS X
map <Esc>Oq 1
map <Esc>Or 2
map <Esc>Os 3
map <Esc>Ot 4
map <Esc>Ou 5
map <Esc>Ov 6
map <Esc>Ow 7
map <Esc>Ox 8
map <Esc>Oy 9
map <Esc>Op 0
map <Esc>On .
map <Esc>OQ /
map <Esc>OR *
map <kPlus> +
map <Esc>OS -
map! <Esc>Oq 1
map! <Esc>Or 2
map! <Esc>Os 3
map! <Esc>Ot 4
map! <Esc>Ou 5
map! <Esc>Ov 6
map! <Esc>Ow 7
map! <Esc>Ox 8
map! <Esc>Oy 9
map! <Esc>Op 0
map! <Esc>On .
map! <Esc>OQ /
map! <Esc>OR *
map! <kPlus> +
map! <Esc>OS -

"}}}
" Abbreviations -------------------------------------------------------{{{

" common misspellings
:iabbrev adn and
:iabbrev waht what
:iabbrev taht that
:iabbrev teh the
:iabbrev treu true
:iabbrev fro for

" handy inserters
:iabbrev <expr> dts strftime("%a, %d %b %Y")

"}}}
" Local vimrc ---------------------------------------------------------{{{

if filereadable(expand("$HOME/.vimrc-local"))
    source $HOME/.vimrc-local
endif

"}}}
