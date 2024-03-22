-- ========================================================================== --
-- ==                               COMMANDS                               == --
-- ========================================================================== --

-- User commands
vim.api.nvim_create_user_command("ReloadConfig", "source $MYVIMRC", { desc = "Reload the vim configuration" })

-- Auto commands
local augroup = vim.api.nvim_create_augroup("user_cmds", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	desc = "Highlight on yank",
	callback = function(event)
		vim.highlight.on_yank({ higroup = "Visual", timeout = 100 })
	end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	desc = "Open file at the last position it was edited earlier",
	group = augroup,
	pattern = "*",
	command = 'silent! normal! g`"zv',
})

local function get_paragraph_node()
	-- Make sure the tree is parsed first.
	vim.treesitter.get_parser():parse()

	local ts_node = vim.treesitter.get_node()

	-- The node can be nil either because no node has be found initially
	-- or because we have reached the parent of the root node.
	while ts_node ~= nil do
		if ts_node:type() == "paragraph" then
			return ts_node
		end

		ts_node = ts_node:parent()
	end

	return nil
end

local function autoformat_paragraph()
	local ts_node = get_paragraph_node()

	if ts_node == nil then
		return
	end

	local cursor_position = vim.api.nvim_win_get_cursor(0)

	vim.cmd("normal! vapgq")
	vim.api.nvim_win_set_cursor(0, cursor_position)
end
-- Automatically use 'gq' when leaving insert-mode.
-- vim.api.nvim_create_autocmd("InsertLeave", {
-- 	desc = "Use 'qg' when leaving insert-mode",
-- 	group = augroup,
-- 	pattern = "*",
-- 	callback = autoformat_paragraph,
-- })
