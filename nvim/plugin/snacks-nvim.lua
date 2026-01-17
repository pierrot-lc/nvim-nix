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
	gitbrowse = { what = "repo" },
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
		toggles = {
			animate = false,
			diagnostics = false,
			dim = true,
			git_signs = false,
			line_number = false,
			mini_indent = false,
			relative_number = false,
			signcolumn = "no",
		},
	},
})

Snacks.toggle.new({
	id = "mini_indent",
	name = "mini_indent",
	get = function() return not vim.b.miniindentscope_disable end,
	set = function(state) vim.b.miniindentscope_disable = not state end,
})

Snacks.toggle.new({
	id = "wrap_lines",
	name = "wrap_lines",
	get = function() return vim.opt.wrap:get() end,
	set = function(state) vim.opt.wrap = state end,
}):map("<leader>sw", { desc = "Toggle wrapped lines" })

vim.keymap.set({ "n", "i", "t" }, "<C-g>", Snacks.terminal.toggle, { desc = "Toggle term" })
vim.keymap.set("n", "<leader>zz", Snacks.zen.zoom, { desc = "Zoom" })
vim.api.nvim_create_user_command("Zen", Snacks.zen.zen, { desc = "Zen-mode" })
vim.api.nvim_create_user_command("GitBrowse", Snacks.gitbrowse.open, { desc = "Browse current git repository" })
