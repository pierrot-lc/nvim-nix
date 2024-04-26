require("catppuccin").setup({
	transparent_background = vim.g.transparent_background,
})

if vim.g.theme == "catppuccin" then
	vim.cmd("colorscheme catppuccin")
end
