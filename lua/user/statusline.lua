-- vim.cmd([[
-- set statusline=
-- set statusline+=\ %h\ %f\ %m
-- set statusline+=\ %p%{'%'}\ %l:%L\ %c
-- " set statusline+=\ %{GitBranch()}
-- ]])

local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	print "could not load lualine"
	return
end

lualine.setup {
	options = {
		icons_enabled = true,
		theme = 'auto',
		component_separators = { left = '', right = ''},
		section_separators = { left = '', right = ''},
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = false,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		}
	},
	sections = {
		lualine_a = {'mode'},
		lualine_b = {'branch', 'diff', 'diagnostics'},
		lualine_c = {'filename'},
		lualine_x = {'encoding', 'fileformat', 'filetype'},
		lualine_y = {'progress'},
		lualine_z = {'location'},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {'filename'},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {}
	},
	tabline = {
-- 		lualine_a = {
-- 			{
-- 				'tabs',
-- 				tabs_color = {
-- 					active = 'lualine_a_normal',
-- 					inactive = 'lualine_b_inactive',
-- 				},
-- 			}
-- 		},
-- 		lualine_z = {'filename'},
	},
	winbar = {},
	inactive_winbar = {},
	extensions = {}
}
