local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	vim.notify("Could not load nvim-lsp-installer...")
	return
end

lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}

	-- if server.name == "sumneko_lua" then
	-- 	local sumneko_opts = require("user.lsp.settings.sumneko_lua")
	-- 	opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	-- end

	if server.name == "pylsp" then
		local pylsp_opts = require("user.lsp.settings.pylsp")
		opts = vim.tbl_deep_extend("force", pylsp_opts, opts)
	end

	server:setup(opts)
end)
