require("lint").linters_by_ft = {
	markdown = { "markdownlint", "proselint" },
	norg = { "proselint" },
	sh = { "shellcheck" },
	yaml = { "yamllint" },
}

vim.api.nvim_create_autocmd({
	"BufWritePost",
	"BufReadPost",
}, {
	callback = function()
		require("lint").try_lint()
	end,
})
