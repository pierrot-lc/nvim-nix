---Pencil is a Lua module that provides utilities for writing text in Neovim.
---It is inspired by the Vim plugin [vim-pencil](https://github.com/preservim/vim-pencil).

---Use treesitter to find the node that represents the paragraph where the
---cursor is. This function returns the paragraph node if found, otherwise it
---returns nil.
---@return userdata|nil
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

---Format the paragraph where the cursor is. The paragraph is formatted
---according to the given `textwidth` (local buffer value if not provided).
---@param textwidth? number: The textwidth to use for formatting, defaults to
---buffer value if not provided.
---@return boolean: Whether the paragraph has been formatted or not.
local function format_paragraph(textwidth)
	textwidth = textwidth or vim.bo.textwidth
	local ts_node = get_paragraph_node()

	if ts_node == nil then
		return false
	end

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
	vim.cmd("normal! gvgq")

	-- Restore original textwidth.
	vim.bo.textwidth = prev_textwidth

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
