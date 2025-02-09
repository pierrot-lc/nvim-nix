local header = [[
   ⸝○⸜   
○---○---○
○---○---○
○---○---○
   ⸌○⸍   
]]
local footer = "Go deep!"

require("snacks").setup({
	bigfile = {
		enabled = true,
	},
	dashboard = {
		enabled = true,
		preset = {
			keys = {
				{ icon = "󰈢 ", key = "<Leader>f", desc = "Find file", action = MiniPick.builtin.files },
				{ icon = "󰺮 ", key = "<Leader>g", desc = "Live grep", action = MiniPick.builtin.grep_live },
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
	quickfile = {},
	statuscolumn = {
		enabled = true,
		folds = {
			open = false,
			git_hl = true,
		},
		git = {
			patterns = { "MiniDiffSign" },
		},
	},
	terminal = {
		win = {
			position = "float",
			style = "terminal",
		},
	},
	zen = {
		on_open = function(_)
			vim.b.miniindentscope_disable = true
			vim.b.snacks_animate = false
			vim.diagnostic.enable(false)
			vim.wo.number = false
			vim.wo.relativenumber = false
			vim.wo.signcolumn = "no"
		end,
		on_close = function(_)
			vim.b.miniindentscope_disable = false
			vim.diagnostic.enable(true)
		end,
	},
})

vim.keymap.set({ "n", "i", "t" }, "<C-g>", Snacks.terminal.toggle, { desc = "Toggle term" })
vim.keymap.set("n", "<leader>zz", Snacks.zen.zoom, { desc = "Zoom" })
vim.api.nvim_create_user_command("Zen", Snacks.zen.zen, { desc = "Zen-mode" })
