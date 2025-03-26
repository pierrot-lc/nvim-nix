require("blink.cmp").setup({
	completion = {
		accept = { auto_brackets = { enabled = false } },
		documentation = { auto_show = true, auto_show_delay_ms = 0 },
		ghost_text = { enabled = true },
		list = { selection = { preselect = false, auto_insert = true } },
		menu = { draw = { treesitter = { "lsp" } } },
	},
	keymap = { preset = "default" },
	signature = { enabled = true },
	sources = {
		default = { "buffer", "emoji", "lsp", "path", "ripgrep", "snippets" },
		providers = {
			emoji = {
				name = "Emoji",
				module = "blink-emoji",
				score_offset = 15,
			},
			ripgrep = {
				name = "Ripgrep",
				module = "blink-ripgrep",
				score_offset = -10,
			},
		},
	},
})
