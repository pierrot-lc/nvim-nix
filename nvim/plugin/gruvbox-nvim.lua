require("gruvbox").setup({
	transparent_mode = vim.g.transparent_background,
})

if vim.g.theme == "gruvbox" then
	vim.cmd("colorscheme gruvbox")
end

if vim.g.theme == "gruvbox-dark" then
	vim.opt.background = "dark"
	vim.cmd("colorscheme gruvbox")
end

if vim.g.theme == "gruvbox-light" then
	vim.opt.background = "light"
	vim.cmd("colorscheme gruvbox")
end
