--- Uses Treesitter to get the scope of the current node of the cursor.
--- Based on this we can automatically truncate the lines of the given
--- context. Mainly, it truncate the lines of the `paragraph` nodes.
--- It can also truncate lines for the inline comments.
local pencil = {}
local ts = require("nvim-treesitter")
local parsers = require("nvim-treesitter.parsers")

pencil.truncate_once = function(line, max_length)
	local truncated = string.sub(line, 1, max_length)
	local rest = string.sub(line, max_length + 1)
	return truncated, rest
end

pencil.truncate_all = function(line, max_length)
	local truncateds = {}
	local trunc = ""

	repeat
		trunc, line = pencil.truncate_once(line, max_length)
		table.insert(truncateds, trunc)
	until #line == 0

	return truncateds
end

pencil.truncate = function()
	local line = vim.api.nvim_get_current_line()
	local max_length = 20

	local truncateds = pencil.truncate_all(line, max_length)
	local merged = table.concat(truncateds, "\n")

	-- Write the truncated lines to the buffer.
	vim.api.nvim_buf_set_lines(0, 0, 1, false, truncateds)
end


--- Check if the cursor is in a treesitter paragraph.
--- If this is the case, this function returns the whole paragraph lines.
pencil.get_paragraph = function()
	-- Make sure the tree is parsed first.
	vim.treesitter.get_parser():parse()

	local ts_node = vim.treesitter.get_node()

	-- The node can be nil either because no node has be found initially
	-- or because we have reached the parent of the root node.
	while ts_node ~= nil do
		if ts_node:type() == "paragraph" then
			local start_row  = ts_node:start()
			local end_row = ts_node:end_()
			local lines = vim.api.nvim_buf_get_lines(0, start_row, end_row, false)
			return lines
		end

		ts_node = ts_node:parent()
	end

	return nil
end

pencil.get_commentstring = function()
	local mini_comment = require("mini.comment")
	local cursor_position = vim.api.nvim_win_get_cursor(0)
	return mini_comment.get_commentstring(cursor_position)
end

return pencil
