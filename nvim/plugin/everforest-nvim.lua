require("everforest").setup({
	italics = true,
	float_style = "dim",
})

if vim.g.theme == "everforest" then
	vim.cmd("colorscheme everforest")
end
