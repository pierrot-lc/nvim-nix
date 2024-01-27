local function on_attach(bufnr)
	local api = require("nvim-tree.api")
	api.config.mappings.default_on_attach(bufnr)

	vim.keymap.set(
		"n",
		"l",
		api.node.open.edit,
		{ desc = "Open", buffer = bufnr, noremap = true, silent = true, nowait = true }
	)
end

require("nvim-tree").setup({
	on_attach = on_attach,
	update_cwd = true,
	update_focused_file = {
		enable = false,
		update_cwd = false,
	},
	view = {
		float = {
			enable = true,
			quit_on_focus_loss = true,
			open_win_config = { border = "none" },
		},
	},
})

vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file explorer" })
