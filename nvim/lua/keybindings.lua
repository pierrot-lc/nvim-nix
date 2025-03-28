-- ========================================================================== --
-- ==                             KEYBINDINGS                              == --
-- ========================================================================== --
--
-- Some are taken from https://github.com/Abstract-IDE/abstract-autocmds/blob/main/lua/abstract-autocmds/mappings.lua.

--- Check if the given cursor position is valid in the given buffer (i.e. can
--- we move the cursor to that position).
--- @param buffer integer
--- @param pos integer[]  # (row, col) tuple
--- @return boolean
local function is_valid(buffer, pos)
	if vim.api.nvim_buf_line_count(buffer) < pos[1] then
		return false
	end

	local line = vim.api.nvim_buf_get_lines(buffer, pos[1] - 1, pos[1], false)[1]
	if #line <= pos[2] then
		return false
	end

	return true
end

--- Select all text in the current buffer.
--- This function is used to select all text in the current buffer. Once the
--- visual mode is left, the cursor is put back to its original position.
--- @return nil
local function select_all()
	local cursor_position = vim.api.nvim_win_get_cursor(0)
	vim.api.nvim_buf_set_mark(0, "C", cursor_position[1], cursor_position[2], {})

	vim.cmd("normal! ggVG")

	-- Add a hook for the next time we leave the visual mode so that
	-- the cursor is put back to its original position.
	vim.api.nvim_create_autocmd("ModeChanged", {
		callback = function()
			local pos = vim.api.nvim_buf_get_mark(0, "C")
			if is_valid(0, pos) then
				vim.api.nvim_win_set_cursor(0, pos)
			end
		end,
		once = true,
	})
end

vim.keymap.set("n", "<leader>w", "<cmd>write<cr>", { desc = "Save" })
vim.keymap.set("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit" })
vim.keymap.set("n", "<leader>x", "<cmd>x<cr>", { desc = "Save and quit" })
vim.keymap.set("n", "<leader>h", "<cmd>nohl<cr>", { desc = "Remove highlights" })
vim.keymap.set("n", "<leader>a", select_all, { desc = "Select all text in current buffer" })
vim.keymap.set("n", "<leader>r", "<cmd>InspectTree<cr>", { desc = "Show parsed tree" })

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
end, { desc = "Smart dd", expr = true })

-- Jumps
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Quick move to bottom buffer" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Quick move to upper buffer" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Quick move to left buffer" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Quick move to right buffer" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down from center", silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up from center", silent = true })

-- Move blocks
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move block down", silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move block up", silent = true })

-- Tab management
-- Quick tip: you can zoom-in and zoom-out using tab split and tab close!
vim.keymap.set("n", "<leader>zn", "<cmd>tabnew<cr>", { desc = "New tab" })
vim.keymap.set("n", "<leader>zs", "<cmd>tab split<cr>", { desc = "Split tab" })
vim.keymap.set("n", "<leader>zc", "<cmd>tab close<cr>", { desc = "Close tab" })

-- Format
vim.keymap.set("v", "<leader>s", ":sort<cr>", { desc = "Sort lines", silent = true })
