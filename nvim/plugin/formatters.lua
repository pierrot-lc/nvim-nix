require("conform").setup({
	formatters_by_ft = {
		json = { "jq" },
		just = { "just" },
		latex = { "latexindent" },
		lua = { "stylua" },
		nix = { "alejandra" },
		python = { "isort" },
		sh = { "shfmt" },
		tex = { "latexindent" },
	},
})
require("conform").formatters.latexindent = {
	command = "latexindent.pl",
}
vim.keymap.set("n", "<leader>F", require("conform").format, { desc = "Format" })
