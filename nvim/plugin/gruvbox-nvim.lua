require("gruvbox").setup({
	transparent_mode = vim.g.transparent_background,
})

if vim.g.theme == "gruvbox" then
	vim.cmd("colorscheme gruvbox")
end
