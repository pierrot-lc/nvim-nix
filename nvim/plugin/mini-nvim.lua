require("mini.diff").setup()
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

require("mini.splitjoin").setup({
	mappings = {
		toggle = "<Leader>gs",
	},
})
