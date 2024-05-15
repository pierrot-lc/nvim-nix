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

-- Courtesy of https://github.com/Abstract-IDE/abstract-autocmds/blob/main/lua/abstract-autocmds/autocmds.lua.
vim.api.nvim_create_autocmd("BufEnter", {
	desc = "Disable ctrl+z",
	group = augroup,
	pattern = "*",
	command = "nnoremap <buffer> <C-z> <nop>",
})

-- Setting a non-zero value to `textwidth` will make vim use the autoformat (t)
-- component of formatoptions.
vim.api.nvim_create_autocmd("FileType", {
	desc = "Remove 't' from formatoptions",
	group = augroup,
	pattern = "*",
	command = "setlocal formatoptions-=t",
})
vim.api.nvim_create_autocmd("FileType", {
	desc = "Add 'q' from formatoptions",
	group = augroup,
	pattern = "*",
	command = "setlocal formatoptions-=t",
})

return {
	augroup = augroup,
}
