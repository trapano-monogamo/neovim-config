if exists("g:loaded_neovim_calculator")
	finish
endif
let g:loaded_neovim_calculator = 1

if !exists("s:calculatorJob")
	let s:calculatorJob = 0
endif

" let s:bin = '~/.config/nvim/myplugins/calculator/target/release/calculator'
let s:bin = '/home/noemi/.config/nvim/myplugins/calculator/target/release/calculator'


function! s:connect()
	let id = s:initRpc()

	if 0 == id
		echo "calculator: cannot start rpc process"
	elseif -1 == id
		echo "calculator: rpc process is not executable"
	else
		let s:calculatorJob = id
		call s:configureCommands()
	endif
endfunction


function! s:initRpc()
	if s:calculatorJob == 0
		let jobid = jobstart([s:bin], { 'rpc': v:true })
		return jobid
	else
		return calculatorJob
	endif
endfunction


function! s:configureCommands()
	command! -nargs=+ Add :call s:add(<f-args>)
	command! -nargs=+ Multiply :call s:multiply(<f-args>)
endfunction


function! s:add(...)
	let s:p = get(a:, 1, 0)
	let s:q = get(a:, 2, 0)
	call rpcnotify(s:calculatorJob, 'add', str2nr(s:p), str2nr(s:q))
endfunction

function! s:multiply(...)
	let s:p = get(a:, 1, 1)
	let s:q = get(a:, 2, 1)
	call rpcnotify(s:calculatorJob, 'multiply', str2nr(s:p), str2nr(s:q))
endfunction


call s:connect()
