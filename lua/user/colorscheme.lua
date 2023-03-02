-- required by "catppuccin" themes
vim.g.catppuccin_flavour = "macchiato"
require("catppuccin").setup()

vim.opt.termguicolors = true
local colorscheme = "catppuccin"
local transparent = false

-- theme specific customization
vim.cmd([[
let ayucolor="dark"
let g:custom_andromeda_transparent = 1
let g:PaperColor_Theme_Options = {'theme': {'default': {'transparent_background': 0}}}
let g:monokaipro_filter = "spectrum"
let g:monokaipro_sidebars = [ "vista_kind", "packer" ]
]])

require('nightfox').setup({
	options = {
		styles = {
			comments = "italic",
			keywords = "bold",
			types = "italic,bold",
		}
	}
})

require('kanagawa').setup({
	undercurl = true,           -- enable undercurls
	commentStyle = { italic = false },
	functionStyle = {},
	keywordStyle = { bold = true},
	statementStyle = { bold = true },
	typeStyle = {},
	variablebuiltinStyle = { italic = true},
	specialReturn = true,       -- special highlight for the return keyword
	specialException = true,    -- special highlight for exception handling keywords
	transparent = false,        -- do not set background color
	dimInactive = false,        -- dim inactive window `:h hl-NormalNC`
	globalStatus = false,       -- adjust window separators highlight for laststatus=3
	terminalColors = true,      -- define vim.g.terminal_color_{0,17}
	colors = {},
	overrides = {},
	theme = "default"           -- Load "default" theme or the experimental "light" theme
})

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	vim.notify("Could not load colorscheme '" .. colorscheme .. "'")
	return
end

vim.cmd([[
set colorcolumn=
highlight ColorColumn guibg=#43454a
]])

if transparent then
	vim.cmd([[
		highlight Normal guibg=none
		highlight NvimTreeNormal guibg=none
		highlight NonText guifg=bg guibg=none
		highlight NormalNC guibg=none
		highlight NormalSB guibg=none
		highlight NvimTreeVertSplit guibg=none
		highlight SignColumn guibg=none
		highlight WinSeparator guibg=none
		highlight LineNr guibg=none
	]])
end
