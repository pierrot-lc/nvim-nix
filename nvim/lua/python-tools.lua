--- Simpler replacement of https://github.com/chrisgrieser/nvim-puppeteer for
--- python f-strings only.

--- Find the starting position of the string under the current cursor. If the
--- cursor is not hovering a string, this function returns nil.
---
--- NOTE: A better version of this would be to search for the next string on the
--- right from the current position of the cursor. This could be done using a
--- treesitter query or simply a f-jump.
---
---@return table|nil
local function string_start_position()
	local parser = vim.treesitter.get_parser(0, "python")
	if not parser then
		vim.notify("python treesitter parser missing!", vim.log.levels.ERROR)
		return
	end

	-- Make sure the tree is parsed first.
	parser:parse()

	local node = vim.treesitter.get_node()
	if not node then
		return
	end

	-- Progressively move to the left to look for "string_start".
	while node and node:type() ~= "string_start" do
		if node:prev_sibling() then
			node = node:prev_sibling()
		else
			node = node:parent()
		end
	end

	if not node then
		return
	end

	local start_row, start_col, _, _ = node:range()
	return {
		start_row = start_row,
		start_col = start_col,
	}
end

--- Add or remove the f-string under the current cursor.
local function puppeteer()
	local pos = string_start_position()
	if not pos then
		return
	end

	local start_row, start_col = pos.start_row, pos.start_col
	local char = vim.api.nvim_buf_get_text(0, start_row, start_col, start_row, start_col + 1, {})[1]

	if char == "f" then
		-- Remove the f-string.
		vim.api.nvim_buf_set_text(0, start_row, start_col, start_row, start_col + 1, {})
	else
		-- Add the f-string.
		vim.api.nvim_buf_set_text(0, start_row, start_col, start_row, start_col + 1, { "f" .. char })
	end
end

--- Insert a doc-strings below the current cursor and go to insert mode.
local function insert_docstrings()
	-- Insert a new line below and start half of the doc-string.
	vim.cmd('normal! o"""')

	-- Indent and complete the doc-string.
	vim.cmd('normal! ==A"""')

	-- Move the cursor to the center of the doc-string and go to insert mode.
	local cursor_position = vim.api.nvim_win_get_cursor(0)
	vim.api.nvim_win_set_cursor(0, { cursor_position[1], cursor_position[2] - 3 })
	vim.api.nvim_feedkeys("a", "n", true)
end

return {
	insert_docstrings = insert_docstrings,
	puppeteer = puppeteer,
}
