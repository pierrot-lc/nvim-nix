require("mini.diff").setup()
require("mini.extra").setup()
require("mini.git").setup()
require("mini.icons").setup()
require("mini.pairs").setup()
require("mini.statusline").setup()
require("mini.surround").setup()

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
vim.keymap.set("n", "<Leader>f", MiniPick.builtin.files, { desc = "Find files" })
vim.keymap.set("n", "<Leader>tl", MiniPick.builtin.grep_live, { desc = "Live grep" })
vim.keymap.set("n", "<Leader>tb", MiniPick.builtin.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<Leader>th", MiniPick.builtin.help, { desc = "Help tags" })
vim.keymap.set("n", "<Leader>tp", MiniPick.builtin.resume, { desc = "Resume previous pick" })

require("mini.splitjoin").setup({
	mappings = {
		toggle = "<Leader>gs",
	},
})
