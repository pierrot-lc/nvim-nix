local catppuccin_dark = {
	["catppuccin-mocha"] = "mocha",
	["catppuccin-macchiato"] = "macchiato",
}
local catppuccin_light = {
	["catppuccin-mocha"] = "latte",
	["catppuccin-macchiato"] = "frappe",
}
require("catppuccin").setup({
	background = {
		light = catppuccin_light[vim.g.theme],
		dark = catppuccin_dark[vim.g.theme],
	},
})

require("everforest").setup({
	background = "hard",
	float_style = "dim",
	italics = true,
})

require("gruvbox").setup({
	contrast = "hard",
})

require("rose-pine").setup({
	dark_variant = "main",
})

local themes = {
	["catppuccin-mocha"] = "catppuccin",
	["catppuccin-macchiato"] = "catppuccin",
	["everforest"] = "everforest",
	["gruvbox"] = "gruvbox",
	["rose-pine"] = "rose-pine",
}
vim.cmd("colorscheme " .. themes[vim.g.theme])
