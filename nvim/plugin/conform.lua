require("conform").setup({
	formatters_by_ft = {
		bib = { "bibtex-tidy" },
		json = { "jq" },
		just = { "just" },
		lua = { "stylua" },
		markdown = { "injected" },
		neorg = { "injected" },
		nix = { "alejandra" },
		sh = { "shfmt" },
	},
})

vim.keymap.set("n", "<leader>F", require("conform").format, { desc = "Format" })
