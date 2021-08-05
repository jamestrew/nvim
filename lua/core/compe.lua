local M = {}

M.config = function()
	require("compe").setup({
		enabled = true,
		autocomplete = true,
		debug = false,
		min_length = 1,
		preselect = "enable",
		throttle_time = 80,
		source_timeout = 200,
		incomplete_delay = 400,
		max_abbr_width = 100,
		max_kind_width = 100,
		max_menu_width = 100,
		documentation = true,
		source = {
			path = true,
			buffer = { kind = "﬘", true },
			luasnip = { kind = "﬌", true },
			nvim_lsp = true,
			nvim_lua = true,
		},
	})

	vim.opt.completeopt = { "menuone", "noselect" }
	vim.opt.shortmess:append("c")
end

return M
