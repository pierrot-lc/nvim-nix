--- Pencil is a Lua module that provides utilities for writing text in Neovim.
--- It is inspired by the Vim plugin [vim-pencil](https://github.com/preservim/vim-pencil).

--- Use treesitter to find the node that represents the paragraph where the
--- cursor is. This function returns the paragraph node if found, otherwise it
--- returns nil.
--- @return table|nil
local function get_paragraph_range()
	-- Make sure the tree is parsed first.
	vim.treesitter.get_parser():parse()

	local node = vim.treesitter.get_node()
	if not node then
		return
	end

	-- The node can be nil either because no node has be found initially
	-- or because we have reached the parent of the root node.
	while node:type() ~= "paragraph" do
		node = node:parent()
		if not node then
			return
		end
	end

	local start_row, start_col, end_row, end_col = node:range()
	return {
		start_row = start_row,
		start_col = start_col,
		end_row = end_row,
		end_col = end_col,
	}
end

--- Format the paragraph where the cursor is. The paragraph is formatted
--- according to the given `textwidth` (local buffer value if not provided).
--- @return boolean: Whether the paragraph has been formatted or not.
local function format_paragraph()
	local range = get_paragraph_range()

	if not range then
		return false
	end

	if range.end_col == 0 then
		-- The end_col is 0 when the paragraph ends with a newline.
		-- In this case, we need to adjust the end_row and end_col.
		local end_line = vim.api.nvim_buf_get_lines(0, range.end_row - 1, range.end_row, false)[1]
		range.end_col = #end_line
		range.end_row = range.end_row - 1
	end

	-- Use a mark to watch follow the original position movement.
	local cursor_position = vim.api.nvim_win_get_cursor(0)
	vim.api.nvim_buf_set_mark(0, "C", cursor_position[1], cursor_position[2], {})

	vim.api.nvim_buf_set_mark(0, "<", range.start_row + 1, range.start_col, {})
	vim.api.nvim_buf_set_mark(0, ">", range.end_row + 1, range.end_col - 1, {})

	-- Format with `gq`.
	vim.cmd("normal! gvgq")

	-- Set the cursor to its new position.
	local new_cursor_position = vim.api.nvim_buf_get_mark(0, "C")
	vim.api.nvim_win_set_cursor(0, new_cursor_position)

	return true
end

-- Smart gqq.
vim.keymap.set("n", "gqq", function()
	-- Try to format the paragraph under the cursor.
	if not require("pencil").format_paragraph() then
		-- Fallback to classical line formatting if no paragraph has been found.
		vim.cmd("normal! gqq")
	end
end, { desc = "Format paragraph/line" })

return {
	format_paragraph = format_paragraph,
}
