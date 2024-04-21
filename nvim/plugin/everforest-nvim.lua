require("everforest").setup({
	transparent_background_level = vim.g.transparent_background and 2 or 0,
	italics = true,
	float_style = "dim",
})

if vim.g.theme == "everforest" then
	vim.cmd("colorscheme everforest")
end
