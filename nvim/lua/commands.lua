-- ========================================================================== --
-- ==                               COMMANDS                               == --
-- ========================================================================== --

-- Auto commands
local augroup = vim.api.nvim_create_augroup("user_cmds", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	desc = "Highlight on yank",
	callback = function(event)
		vim.highlight.on_yank({ higroup = "Visual", timeout = 100 })
	end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	desc = "Open file at the last position it was edited earlier",
	group = augroup,
	pattern = "*",
	command = 'silent! normal! g`"zv',
})

return {
	augroup = augroup,
}
