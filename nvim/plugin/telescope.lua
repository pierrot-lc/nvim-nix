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
vim.keymap.set("n", "<Leader>f", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<Leader>tg", builtin.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<Leader>tb", builtin.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<Leader>ts", builtin.treesitter, { desc = "Treesitter symbols" })
vim.keymap.set("n", "<Leader>tt", builtin.help_tags, { desc = "Help tags" })
vim.keymap.set("n", "<Leader>tl", builtin.lsp_document_symbols, { desc = "LSP document symbols" })
vim.keymap.set("n", "<Leader>tc", builtin.commands, { desc = "Commands" })
vim.keymap.set("n", "<Leader>tm", builtin.marks, { desc = "Marks" })
vim.keymap.set("n", "<Leader>tp", builtin.resume, { desc = "Resume previous search" })
vim.keymap.set("n", "<Leader>ty", function()
	builtin.find_files({ search_file = "yaml" })
end, { desc = "Search for yaml files" })
