require("mini.diff").setup()
require("mini.extra").setup()
require("mini.git").setup()
require("mini.icons").setup()
require("mini.pairs").setup()
require("mini.statusline").setup()
require("mini.surround").setup()

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
vim.keymap.set("n", "<leader>tg", MiniPick.builtin.grep_live, { desc = "Live grep" })
vim.keymap.set("n", "<leader>tb", MiniPick.builtin.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>th", MiniPick.builtin.help, { desc = "Help tags" })
vim.keymap.set("n", "<leader>tp", MiniPick.builtin.resume, { desc = "Resume previous pick" })

require("mini.splitjoin").setup({
	mappings = {
		toggle = "<leader>gs",
	},
})
