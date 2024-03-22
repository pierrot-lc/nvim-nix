-- ========================================================================== --
-- ==                             KEYBINDINGS                              == --
-- ========================================================================== --

--- Select all text in the current buffer.
--- This function is used to select all text in the current buffer.
---
--- Once the visual mode is left, the cursor is put back to its original
--- position.
local function select_all()
	local cursor_position = vim.api.nvim_win_get_cursor(0)

	vim.cmd("normal! ggVG")

	-- Add a hook for the next time we leave the visual mode so that
	-- the cursor is put back to its original position.
	vim.api.nvim_create_autocmd("ModeChanged", {
		callback = function()
			vim.api.nvim_win_set_cursor(0, cursor_position)
		end,
		once = true,
	})
end

vim.keymap.set("n", "<leader>w", "<cmd>write<cr>", { desc = "Save" })
vim.keymap.set("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit" })
vim.keymap.set("n", "<leader>x", "<cmd>x<cr>", { desc = "Save and quit" })
vim.keymap.set("n", "<leader>h", "<cmd>nohl<cr>", { desc = "Remove highlights" })
vim.keymap.set("n", "<leader>a", select_all, { desc = "Select all text in current buffer" })

-- Copy/paste
vim.keymap.set({ "n", "x" }, "cp", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set({ "n", "x" }, "cv", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set("n", "x", '"_x', { desc = "Delete without changing internal clipboard" })

-- Window jumps
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Quick move to bottom buffer" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Quick move to upper buffer" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Quick move to left buffer" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Quick move to right buffer" })

-- Tab management
-- Quick tip: you can zoom-in and zoom-out using tab split and tab close!
vim.keymap.set("n", "<leader>zn", "<cmd>tabnew<cr>", { desc = "New tab" })
vim.keymap.set("n", "<leader>zs", "<cmd>tab split<cr>", { desc = "Split tab" })
vim.keymap.set("n", "<leader>zc", "<cmd>tab close<cr>", { desc = "Close tab" })
