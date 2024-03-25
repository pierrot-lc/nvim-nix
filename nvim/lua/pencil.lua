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

	-- Select the paragraph pointed by the ts node and format with `gq`.
	local start_row, start_col, end_row, end_col = ts_node:range()
	vim.api.nvim_buf_set_mark(0, "<", start_row + 1, start_col, {})
	vim.api.nvim_buf_set_mark(0, ">", end_row + 1, end_col, {})
	vim.cmd("normal! gvgq")

	-- Place the cursor back to the original mark.
	local new_cursor_position = vim.api.nvim_buf_get_mark(0, "C")
	vim.api.nvim_win_set_cursor(0, new_cursor_position)

	-- Reset the textwidth.
	vim.bo.textwidth = prev_textwidth
end

return {
	autoformat_paragraph = autoformat_paragraph,
}
