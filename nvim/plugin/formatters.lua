require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort" },
		sh = { "shfmt" },
		json = { "jq" },
		latex = { "latexindent" },
		tex = { "latexindent" },
	},
})
require("conform").formatters.latexindent = {
	command = "latexindent.pl",
}
vim.keymap.set("n", "<leader>F", require("conform").format, { desc = "Format" })
