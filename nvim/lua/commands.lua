-- ========================================================================== --
-- ==                               COMMANDS                               == --
-- ========================================================================== --

-- User commands
vim.api.nvim_create_user_command("ReloadConfig", "source $MYVIMRC", { desc = "Reload the vim configuration" })

-- Auto commands
local augroup = vim.api.nvim_create_augroup("user_cmds", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	desc = "Highlight on yank",
	callback = function(event)
		vim.highlight.on_yank({ higroup = "Visual", timeout = 100 })
	end,
})
