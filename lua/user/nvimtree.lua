vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local status_ok, nvimtree = pcall(require, "nvim-tree")
if not status_ok then
	print "Could not load nvimtree"
	return
end

nvimtree.setup({
	sort_by = "case_sensitive",
	view = {
		adaptive_size = true,
		mappings = {
			list = {
				{ key = "u", action = "dir_up" },
			},
		},
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = true,
	},
})
