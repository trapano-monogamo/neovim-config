if exists("g:loaded_badapple")
	finish
endif
let g:loaded_badapple = 1

if !exists("s:badapple_job")
	let s:badapple_job = 0
endif

let s:bin = '/home/noemi/.config/nvim/myplugins/badapple/target/debug/badapple'


function! s:connect()
	let id = s:init_rpc()

	if 0 == id
		echo "badapple: cannot start rpc process"
	elseif -1 == id
		echo "badapple: rpc process is not executable"
	else
		let s:badapple_job = id
		call s:configure_commands()
	endif
endfunction


function! s:init_rpc()
	if s:badapple_job == 0
		let jobid = jobstart([s:bin], { 'rpc': v:true })
		return jobid
	else
		return badapple_job
	endif
endfunction


function! s:configure_commands()
	command! -nargs=0 BadApple :call s:bad_apple()
endfunction


function! s:bad_apple()
	call rpcnotify(s:badapple_job, 'bad_apple')
endfunction


call s:connect()
