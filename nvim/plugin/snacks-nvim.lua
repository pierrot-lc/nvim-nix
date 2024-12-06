local header = [[
   ⸝○⸜   
○---○---○
○---○---○
○---○---○
   ⸌○⸍   
]]
local footer = "Go deep!"

require("snacks").setup({
	statuscolumn = {
		enabled = true,
		folds = {
			open = true,
			git_hl = true,
		},
		git = {
			patterns = { "MiniDiffSign" },
		},
	},

	dashboard = {
		enabled = true,
		preset = {
			keys = {
				{ icon = "󰈢 ", key = "f", desc = "Find file", action = MiniPick.builtin.files },
				{ icon = "󰺮 ", key = "l", desc = "Live grep", action = MiniPick.builtin.grep_live },
				{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
			},
			header = header,
		},
		sections = {
			{ section = "header" },
			{ section = "keys", gap = 1, padding = 1 },
			{ text = footer },
		},
	},

	terminal = {
		win = {
			position = "float",
			style = "terminal",
		},
	},
})

-- vim.keymap.set({ "n", "i", "t" }, "<C-g>", Snacks.terminal.toggle, { desc = "Toggle term" })
