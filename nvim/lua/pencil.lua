--- Pencil is a Lua module that provides utilities for writing text in Neovim.
--- It is inspired by the Vim plugin [vim-pencil](https://github.com/preservim/vim-pencil).

--- Use treesitter to find the node that represents the paragraph where the
--- cursor is. This function returns the paragraph node if found, otherwise it
--- returns nil.
--- @return userdata|nil
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

--- Autoformat the paragraph where the cursor is. The paragraph is formatted
--- according to the given `textwidth`. The cursor is placed back to its
--- original position after the formatting.
--- @param textwidth number: The textwidth to use for formatting.
local function autoformat_paragraph(textwidth)
	local ts_node = get_paragraph_node()

	if ts_node == nil then
		return
	end

	-- Mark the current cursor position.
	local cursor_position = vim.api.nvim_win_get_cursor(0)
	vim.api.nvim_buf_set_mark(0, "C", cursor_position[1], cursor_position[2], {})

	-- Modify the textwidth temporarily.
	local prev_textwidth = vim.bo.textwidth
	vim.bo.textwidth = textwidth

	-- Mark the paragraph pointed by the ts node.
	local start_row, start_col, end_row, end_col = ts_node:range()

	if end_col == 0 then
		-- The end_col is 0 when the paragraph ends with a newline.
		-- In this case, we need to adjust the end_row and end_col.
		local end_line = vim.api.nvim_buf_get_lines(0, end_row - 1, end_row, false)[1]
		end_col = #end_line
		end_row = end_row - 1
	end

	vim.api.nvim_buf_set_mark(0, "<", start_row + 1, start_col, {})
	vim.api.nvim_buf_set_mark(0, ">", end_row + 1, end_col, {})

	-- Format with `gq`.
	-- NOTE: Maybe using `gw` instead of `gq` would be easier as
	-- the cursor is already being put back to its original place.
	vim.cmd("normal! gvgq")

	-- Place the cursor back to the original mark.
	local new_cursor_position = vim.api.nvim_buf_get_mark(0, "C")
	vim.api.nvim_win_set_cursor(0, new_cursor_position)

	-- Restore original textwidth.
	vim.bo.textwidth = prev_textwidth
end

return {
	autoformat_paragraph = autoformat_paragraph,
}
