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
