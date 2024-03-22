require("mini.indentscope").setup()

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "help", "alpha", "dashboard", "NvimTree", "Trouble", "lazy", "mason" },
	callback = function()
		vim.b.miniindentscope_disable = true
	end,
})
