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

	-- Select the paragraph pointed by the ts node and format
	-- with `gq`.
	local start_row, start_col, end_row, end_col = ts_node:range()
	vim.api.nvim_buf_set_mark(0, "<", start_row + 1, start_col, {})
	vim.api.nvim_buf_set_mark(0, ">", end_row + 1, end_col, {})
	vim.cmd("normal! gvgq")

	vim.api.nvim_win_set_cursor(0, cursor_position)
end

return {
	autoformat_paragraph = autoformat_paragraph,
}
