local header = [[
   ⸝○⸜   
○---○---○
○---○---○
○---○---○
   ⸌○⸍   
]]

local footer = "Go deep!"

require("snacks").setup({
	dashboard = {
		enabled = true,
		preset = {
			keys = {
				{ icon = "󰈢 ", key = "f", desc = "Find file", action = ":Telescope find_files" },
				{ icon = "󰺮 ", key = "l", desc = "Live grep", action = ":Telescope live_grep" },
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
})
