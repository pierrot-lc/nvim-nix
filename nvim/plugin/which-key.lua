require("which-key").setup({
	preset = "helix",
	delay = 1000,
	icons = {
		mappings = false,
	},
})

require("which-key").add({
	{ "<Leader>g", group = "Others" },
	{ "<Leader>l", group = "LSP & Treesitter" },
	{ "<Leader>t", group = "Telescope" },
	{ "<Leader>z", group = "Tabs" },
	{ "cr", group = "LSP" },
})
