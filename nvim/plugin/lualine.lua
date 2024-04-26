local theme_parser = {
	["catppuccin"] = "catppuccin",
	["everforest"] = "everforest",
	["gruvbox"] = "gruvbox",
	["kanagawa"] = "seoul256",
	["rose-pine"] = "rose-pine",
}

require("lualine").setup({
	options = {
		theme = theme_parser[vim.g.theme],
	},
})
