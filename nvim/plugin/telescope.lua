require("telescope").setup({
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			ovveride_file_sorter = true,
			case_mode = "smart_case",
		},
	},
})
require("telescope").load_extension("fzf") -- telescope-fzf-native.nvim
require("telescope").load_extension("helpgrep") -- telescope-helpgrep.nvim

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>tg", builtin.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>tb", builtin.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>tt", builtin.treesitter, { desc = "Treesitter symbols" })
vim.keymap.set("n", "<leader>tt", builtin.help_tags, { desc = "Help tags" })
vim.keymap.set("n", "<leader>tl", builtin.lsp_document_symbols, { desc = "LSP document symbols" })
vim.keymap.set("n", "<leader>tc", builtin.commands, { desc = "Commands" })
vim.keymap.set("n", "<leader>tm", builtin.marks, { desc = "Marks" })
vim.keymap.set("n", "<leader>tp", builtin.resume, { desc = "Resume previous search" })
