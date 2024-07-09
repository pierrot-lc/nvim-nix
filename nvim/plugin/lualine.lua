local theme_parser = {
	["catppuccin"] = "catppuccin",
	["everforest"] = "everforest",
	["gruvbox"] = "gruvbox",
	["kanagawa"] = "seoul256",
	["melange"] = "melange",
	["melange-light"] = "melange",
	["nord"] = "nord",
	["rose-pine"] = "rose-pine-alt",
	["rose-pine-dawn"] = "rose-pine",
}

require("lualine").setup({
	options = {
		theme = theme_parser[vim.g.theme],
	},
})
