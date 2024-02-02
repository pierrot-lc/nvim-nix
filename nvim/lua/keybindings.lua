-- ========================================================================== --
-- ==                             KEYBINDINGS                              == --
-- ========================================================================== --
vim.keymap.set("n", "<leader>w", "<cmd>write<cr>", { desc = "Save" })
vim.keymap.set("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit" })
vim.keymap.set("n", "<leader>x", "<cmd>x<cr>", { desc = "Save and quit" })
vim.keymap.set("n", "<leader>h", "<cmd>nohl<cr>", { desc = "Remove highlights" })
vim.keymap.set("n", "<leader>a", "<cmd>keepjumps normal! ggVG<cr>", { desc = "Select all text in current buffer" })

-- Copy/paste
vim.keymap.set({ "n", "x" }, "cp", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set({ "n", "x" }, "cv", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set("n", "x", '"_x', { desc = "Delete without changing internal clipboard" })
vim.keymap.set("n", "dd", function()
	if vim.api.nvim_get_current_line():match("^%s*$") then
		return '"_dd'
	else
		return "dd"
	end
end, { desc = "Smart dd, yank only if the line is not empty" })

-- Window jumps
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Quick move to bottom buffer" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Quick move to upper buffer" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Quick move to left buffer" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Quick move to right buffer" })
