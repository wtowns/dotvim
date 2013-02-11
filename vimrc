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

  autocmd BufRead,BufNewFile *.as setfiletype actionscript
  autocmd BufRead,BufNewFile *.xmobarrc setfiletype haskell
  autocmd BufRead,BufNewFile *.pex setfiletype xml

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
set laststatus=2                " Always show status line
set cursorline                  " Show the cursorline
set cursorcolumn                " Show the cursorcolumn
set scrolloff=3                 " Give three lines of top/bottom context in buffers

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" colorscheme
if &t_Co > 2 || has("gui_running")
	set background=dark
	if &term == "rxvt-unicode-256color"
		let g:HemisuTransparentBackground = 1
		colorscheme hemisu
	else
		colorscheme jellybeans
	endif
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

" Enable nice powerline symbols
if &term == "rxvt-unicode-256color"
    " Having font issues on arch at the moment
    set encoding=utf-8
    let Powerline_symbols = 'compatible'
else
    let Powerline_symbols = 'fancy'
endif

" Don't jump to the first item in cscope searches
let Cscope_JumpError = 0

" CtrlP mixed mode by default
let g:ctrlp_cmd = 'CtrlPMixed'
" Search from root project directory in CtrlP
let g:ctrlp_working_path_mode = 2
" Keep the ctrlp cache between sessions
let g:ctrlp_clear_cache_on_exit = 0
" Increase window size
let g:ctrlp_max_height = 20
" Lazy update, but with shorter delay
let g:ctrlp_lazy_update=50

" Remap supertab to ctrl+j and ctrl+shift+j (works in terminal Cygwin, unlike the preferred ctrl+space)
let g:SuperTabMappingForward = '<c-j>'
let g:SuperTabMappingBackward = '<c-k>'

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
nnoremap <Leader>gg :Ack! -i ''<Left>
nnoremap <Leader>gw :Ack! -i ''<Left><C-R><C-W><CR>

" copy to X11 clipboard
vnoremap <Leader>c :call CopyToX11Primary()<CR>

" copy to Windows clipboard
vnoremap <silent> <leader>y :call Putclip(visualmode(), 1)<CR>
nnoremap <silent> <leader>y :call Putclip('n', 1)<CR>

" windows
nnoremap <leader>a <c-w><c-w>

" tab shortcuts
nnoremap H :tabp<CR>
nnoremap L :tabn<CR>
nnoremap <silent> <C-h> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <C-l> :execute 'silent! tabmove ' . tabpagenr()<CR>
nnoremap <Leader>n :tabe<CR>
if has("gui_running")
    map <C-tab> :tabn<CR>
    map <C-S-tab> :tabp<CR>
endif

" tags, files, and buffers
nnoremap <leader>t :FufTag<cr>
nnoremap <leader>o :FufFile<cr>
nnoremap <leader>b :FufBuffer<cr>
nnoremap <leader>f :FufTaggedFile<cr>

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
