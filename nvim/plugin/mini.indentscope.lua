require("mini.indentscope").setup()

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "NvimTree", "Trouble", "help", "snacks_dashboard" },
	callback = function()
		vim.b.miniindentscope_disable = true
	end,
})
