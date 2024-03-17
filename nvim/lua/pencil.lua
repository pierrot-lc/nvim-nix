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

pencil.get_commentstring = function()
	local mini_comment = require("mini.comment")
	local cursor_position = vim.api.nvim_win_get_cursor(0)
	return mini_comment.get_commentstring(cursor_position)
end

return pencil
