-- gruvbox, farout, onenord, jellybeans-nvim, default

--[[ required by "catppuccin" themes
vim.g.catppuccin_flavour = "mocha"
require("catppuccin").setup()
]]--

vim.opt.termguicolors = true
local colorscheme = "nord"
local transparent = true

-- theme specific customization
vim.cmd([[
let ayucolor="dark"

let g:custom_andromeda_transparent = 1

let g:PaperColor_Theme_Options = {'theme': {'default': {'transparent_background': 0}}}

" monokaipro
let g:monokaipro_filter = "spectrum"
let g:monokaipro_sidebars = [ "vista_kind", "packer" ]
]])

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
		highlight NonText guifg=bg guibg=none
	]])
end
