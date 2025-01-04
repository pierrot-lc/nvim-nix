require("blink.cmp").setup({
	keymap = { preset = "default" },
	completion = {
		documentation = { auto_show = true, auto_show_delay_ms = 0 },
		ghost_text = { enabled = true },
		menu = {
			draw = {
				treesitter = { "lsp" },
			},
		},
	},
	signature = { enabled = true },
})

vim.lsp.config("*", {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
	root_markers = { ".git" },
})
