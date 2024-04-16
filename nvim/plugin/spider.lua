local spider = require("spider")

--- Same line jump. If the cursor moves to a different line, the cursor will be
--- moved back to the original line.
--- Credits: https://github.com/yutkat/wb-only-current-line.nvim
--- NOTE: If the move is repeated using [count], the cursor will still be moved back to it's original position.
---
--- @param direction string: The direction to move the cursor.
--- @param move_fn function: The function to move the cursor.
local function same_line_jump(direction, move_fn)
	local cursor_position = vim.api.nvim_win_get_cursor(0)

	move_fn(direction)

	local new_position = vim.api.nvim_win_get_cursor(0)
	if cursor_position[1] ~= new_position[1] then
		vim.api.nvim_win_set_cursor(0, { cursor_position[1], cursor_position[2] })
	end
end

--- Returns a function that jumps to the next word in the given direction. The
--- jump is a "spider" jump.
--- @param direction string
--- @return function
local function spider_jump(direction)
	local jump_function = function()
		same_line_jump(direction, spider.motion)
	end
	return jump_function
end

--- Returns a function that jumps to the next word in the given direction.
--- @param direction string
--- @return function
local function normal_jump(direction)
	local move_fn = function(direction_)
		vim.cmd("normal! " .. direction_)
	end

	local jump_function = function()
		same_line_jump(direction, move_fn)
	end
	return jump_function
end

-- Spider-moves.
vim.keymap.set("n", "w", spider_jump("w"), { desc = "Spider-w" })
vim.keymap.set("n", "e", spider_jump("e"), { desc = "Spider-e" })
vim.keymap.set("n", "b", spider_jump("b"), { desc = "Spider-b" })
vim.keymap.set("n", "ge", spider_jump("ge"), { desc = "Spider-ge" })

-- Normal moves.
vim.keymap.set("n", "W", normal_jump("W"), { desc = "Normal-W" })
vim.keymap.set("n", "E", normal_jump("E"), { desc = "Normal-E" })
vim.keymap.set("n", "B", normal_jump("B"), { desc = "Normal-B" })
vim.keymap.set("n", "gE", normal_jump("gE"), { desc = "Normal-gE" })
