local theme_parser = {
	["catppuccin"] = "catppuccin",
	["everforest"] = "everforest",
	["gruvbox"] = "gruvbox",
	["kanagawa"] = "seoul256",
}

require("lualine").setup({
	options = {
		theme = theme_parser[vim.g.theme],
	},
})
