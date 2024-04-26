require("mini.files").setup({
	options = {
		permanent_delete = true,
		use_as_default_explorer = true,
	},
})

local minifiles_toggle = function()
	if not MiniFiles.close() then
		MiniFiles.open()
	end
end

vim.api.nvim_create_user_command("MiniFiles", minifiles_toggle, { desc = "Toggle MiniFiles" })
vim.keymap.set("n", "<leader>e", minifiles_toggle, { desc = "Toggle file explorer" })
