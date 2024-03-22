local spider = require("spider")
local spider_jump = function(move)
	local jump_function = function()
		spider.motion(move)
	end
	return jump_function
end
vim.keymap.set("n", "w", spider_jump("w"), { desc = "Spider-w" })
vim.keymap.set("n", "e", spider_jump("e"), { desc = "Spider-e" })
vim.keymap.set("n", "b", spider_jump("b"), { desc = "Spider-b" })
vim.keymap.set("n", "ge", spider_jump("ge"), { desc = "Spider-ge" })

require("mini.jump2d").setup()
vim.keymap.set("n", "<leader>s", MiniJump2d.start, { desc = "MiniJump2d" })
