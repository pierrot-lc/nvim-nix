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
	hijack_netrw = false,
	view = {
		float = {
			enable = false,
			quit_on_focus_loss = true,
			open_win_config = { border = "rounded" }, -- See :h nvim_open_win.
		},
	},
})

vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file explorer" })
