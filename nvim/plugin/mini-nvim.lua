require("mini.diff").setup()
require("mini.extra").setup()
require("mini.git").setup()
require("mini.pairs").setup()
require("mini.statusline").setup()
require("mini.surround").setup()

local miniclue = require("mini.clue")
require("mini.clue").setup({
	triggers = {
		-- Leader triggers
		{ mode = "n", keys = "<Leader>" },
		{ mode = "n", keys = "<LocalLeader>" },
		{ mode = "x", keys = "<Leader>" },
		{ mode = "x", keys = "<LocalLeader>" },

		-- Built-in completion
		{ mode = "i", keys = "<C-x>" },

		-- `g` key
		{ mode = "n", keys = "g" },
		{ mode = "x", keys = "g" },

		-- Marks
		{ mode = "n", keys = "'" },
		{ mode = "n", keys = "`" },
		{ mode = "x", keys = "'" },
		{ mode = "x", keys = "`" },

		-- Registers
		{ mode = "n", keys = '"' },
		{ mode = "x", keys = '"' },
		{ mode = "i", keys = "<C-r>" },
		{ mode = "c", keys = "<C-r>" },

		-- Window commands
		{ mode = "n", keys = "<C-w>" },

		-- `z` key
		{ mode = "n", keys = "z" },
		{ mode = "x", keys = "z" },
	},

	clues = {
		{ mode = "n", keys = "<Leader>g", desc = "+Others" },
		{ mode = "n", keys = "<Leader>l", desc = "+LSP & TS" },
		{ mode = "n", keys = "<Leader>t", desc = "+Picks" },
		{ mode = "n", keys = "<Leader>z", desc = "+Tabs" },

		miniclue.gen_clues.builtin_completion(),
		miniclue.gen_clues.g(),
		miniclue.gen_clues.marks(),
		miniclue.gen_clues.registers(),
		miniclue.gen_clues.windows(),
		miniclue.gen_clues.z(),
	},

	window = {
		delay = 100,
	},
})

local hipatterns = require("mini.hipatterns")
hipatterns.setup({
	highlighters = {
		-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
		fixme = {
			pattern = {
				"%f[%w]()FIXME()%f[%W]",
				"%f[%w]()WARN()%f[%W]",
				"%f[%w]()WARNING()%f[%W]",
			},
			group = "MiniHipatternsFixme",
		},
		hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
		note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
		todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },

		-- Highlight hex color strings (`#rrggbb`) using that color
		hex_color = hipatterns.gen_highlighter.hex_color(),
	},
})

require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()

require("mini.indentscope").setup()
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "NvimTree", "Trouble", "help", "snacks_dashboard" },
	callback = function()
		vim.b.miniindentscope_disable = true
	end,
})

local MiniJump2d = require("mini.jump2d")
require("mini.jump2d").setup({
	spotter = MiniJump2d.start(MiniJump2d.builtin_opts.word_start),
	allowed_windows = { not_current = false },
})

require("mini.pick").setup()
vim.keymap.set("n", "<leader>f", MiniPick.builtin.files, { desc = "Find files" })
vim.keymap.set("n", "<leader>g", MiniPick.builtin.grep_live, { desc = "Live grep" })
vim.keymap.set("n", "<leader>tb", MiniPick.builtin.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>th", MiniPick.builtin.help, { desc = "Help tags" })
vim.keymap.set("n", "<leader>tt", MiniPick.builtin.resume, { desc = "Resume previous pick" })

require("mini.splitjoin").setup({
	mappings = {
		toggle = "gs",
	},
})
