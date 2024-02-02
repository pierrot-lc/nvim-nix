vim.cmd("colorscheme kanagawa")

local dashboard = require("alpha.themes.dashboard")
local logo = [[
$$\   $$\                    $$\    $$\ $$\
$$$\  $$ |                   $$ |   $$ |\__|
$$$$\ $$ | $$$$$$\   $$$$$$\ $$ |   $$ |$$\ $$$$$$\$$$$\
$$ $$\$$ |$$  __$$\ $$  __$$\\$$\  $$  |$$ |$$  _$$  _$$\
$$ \$$$$ |$$$$$$$$ |$$ /  $$ |\$$\$$  / $$ |$$ / $$ / $$ |
$$ |\$$$ |$$   ____|$$ |  $$ | \$$$  /  $$ |$$ | $$ | $$ |
$$ | \$$ |\$$$$$$$\ \$$$$$$  |  \$  /   $$ |$$ | $$ | $$ |
\__|  \__| \_______| \______/    \_/    \__|\__| \__| \__|


]]

dashboard.section.header.val = vim.split(logo, "\n")
dashboard.section.buttons.val = {
	dashboard.button("n", " " .. " New file", "<cmd>ene <bar> startinsert<cr>"),
	dashboard.button("p", " " .. " Projects", "<cmd>Telescope repo list<cr>"),
	dashboard.button("r", "󱋡 " .. " Recent files", "<cmd>Telescope oldfiles<cr>"),
	dashboard.button("f", "󰈢 " .. " Find file", "<cmd>Telescope find_files<cr>"),
	dashboard.button("g", "󰺮 " .. " Find text", "<cmd>Telescope live_grep<cr>"),
	dashboard.button("q", " " .. " Quit", "<cmd>qa<cr>"),
}
for _, button in ipairs(dashboard.section.buttons.val) do
	button.opts.hl = "AlphaButtons"
	button.opts.hl_shortcut = "AlphaShortcut"
end
dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "AlphaHeader"
dashboard.section.buttons.opts.hl = "AlphaButtons"
dashboard.opts.layout[1].val = 8

require("alpha").setup(dashboard.opts)

require("lualine").setup({
	options = {
		theme = "auto",
	},
})

require("zen-mode").setup({
	window = {
		options = {
			number = false, -- Disable number column.
			signcolumn = "no",
			cursorline = false,
			cursorcolumn = false,
			foldcolumn = "0", -- Disable fold column.
		},
	},
	plugins = {
		tmux = {
			enabled = true,
		},
		gitsigns = {
			enabled = true,
		},
	},
	on_open = function(_)
		vim.diagnostic.disable()
	end,
	on_close = function()
		vim.diagnostic.enable()
	end,
})
