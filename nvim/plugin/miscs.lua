local augend = require("dial.augend")
require("dial.config").augends:register_group({
	default = {
		augend.integer.alias.decimal,
		augend.integer.alias.hex,
		augend.date.alias["%Y/%m/%d"],
		augend.constant.alias.alpha,
		augend.constant.alias.Alpha,
		augend.constant.alias.bool,
		augend.constant.new({ elements = { "True", "False" } }),
	},
})
vim.api.nvim_set_keymap("n", "<C-a>", require("dial.map").inc_normal(), { noremap = true })
vim.api.nvim_set_keymap("n", "<C-x>", require("dial.map").dec_normal(), { noremap = true })

require("copilot").setup({
	filetypes = {
		["*"] = true, -- Enable for all filetypes.
	},
	suggestion = {
		enabled = true,
		auto_trigger = false, -- Start suggesting as soon as you start typing.
		keymap = {
			accept = "<M-h>",
			accept_word = "<M-l>",
			accept_line = false,
			next = "<M-k>",
			prev = "<M-j>",
			dismiss = false,
		},
	},
	panel = {
		enabled = false,
	},
})

require("nvim-rooter").setup({ manual = true })

require("todo-comments").setup()

require("toggleterm").setup({
	open_mapping = "<C-g>",
	direction = "float",
	shade_terminals = true,
})
