require("kanagawa").setup({
	compile = false,
})

if vim.g.theme == "kanagawa" then
	vim.cmd("colorscheme kanagawa-dragon")
end
