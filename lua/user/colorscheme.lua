-- gruvbox, farout, onenord, jellybeans-nvim, default

--[[ required by "catppuccin" themes
vim.g.catppuccin_flavour = "mocha"
require("catppuccin").setup()
]]--

vim.opt.termguicolors = true
local colorscheme = "customandromeda"
local transparent = true

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	vim.notify("Could not load colorscheme '" .. colorscheme .. "'")
	return
end


-- theme specific customization
vim.cmd([[
let ayucolor="dark"

let g:PaperColor_Theme_Options = {'theme': {'default': {'transparent_background': 0}}}
]])

vim.cmd([[
set colorcolumn=
highlight ColorColumn guibg=#43454a
]])

if transparent then
	vim.cmd([[
		let g:PaperColor_Theme_Options = {'theme': {'default': {'transparent_background': 1}}}
		highlight Normal guibg=none
		highlight NonText guifg=bg guibg=none
	]])
end
