" ..:: Palette ::..

let s:none="none"
let s:bg="#000000"
let s:comments="#000000"
let s:indication="#202020"
let s:selection="#203050"
let s:guide="#2d3640"
let s:block="#aaaaaa"

" ..:: Highlight Groups ::..

function! s:SetHiGroup(group, bg, fg, attr)
	if !empty(a:bg)
		exec 'hi ' .a:group .' guibg=' .a:bg
	endif
	if !empty(a:fg)
		exec 'hi ' .a:group .' guifg=' .a:fg
	endif
	if !empty(a:attr)
		exec 'hi ' .a:group .' gui=' .a:attr
	endif
endfunction

call s:SetHiGroup("VertSplit", s:bg, s:guide, "")
call s:SetHiGroup("NonText", s:bg, s:guide, "")
call s:SetHiGroup("Normal", s:bg, "", "")
call s:SetHiGroup("SignColumn", s:bg, s:guide, "")
call s:SetHiGroup("Pmenu", s:indication, "", "")
call s:SetHiGroup("PmenuSel", s:selection, "", "")
call s:SetHiGroup("LineNr", "", s:guide, "")
call s:SetHiGroup("StatusLine", "#ffffff", "", "")
call s:SetHiGroup("CursorLine", s:indication, "", "")

" ..:: Additional Style ::..

set fillchars=vert:\|
