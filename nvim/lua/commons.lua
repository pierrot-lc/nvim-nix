-- ========================================================================== --
-- ==                          COMMON FILETYPES SETTINS                    == --
-- ========================================================================== --
local augroup = vim.api.nvim_create_augroup("user_common", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	desc = "Set some general shift width",
	pattern = {
		"c",
		"css",
		"gleam",
		"html",
		"htmlangular",
		"htmldjango",
		"markdown",
		"nix",
		"tex",
		"toml",
		"typst",
		"yaml",
	},
	callback = function()
		vim.bo.shiftwidth = 2
		vim.bo.tabstop = 2
	end,
})
