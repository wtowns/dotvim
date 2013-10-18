setlocal number
setlocal ruler

setlocal tabstop=4
setlocal shiftwidth=4
setlocal noexpandtab

:set tags=tags;/

if !exists("*SwitchSourceHeader")
	function! SwitchSourceHeader()
		"update!
		if (expand("%:e") == "cpp")
			:find %:t:r.h
		else
			:find %:t:r.cpp
		endif
	endfunction
endif
nnoremap <buffer> <Leader>z :call SwitchSourceHeader()<CR>
