vim.cmd([[
if exists('+termguicolors')
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[38;2;%lu;%lu;%lum"
	set termguicolors
endif

" if (has("termguicolors"))
" 	set termguicolors
" endif

" set fillchars=eob:\ 
]])
