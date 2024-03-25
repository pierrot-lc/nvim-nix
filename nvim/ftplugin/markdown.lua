-- ========================================================================== --
-- ==                          MARKDOWN SPECIFICS                          == --
-- ========================================================================== --
vim.wo.colorcolumn = ""
vim.wo.wrap = false

-- Autoformat paragraphs.
local textwidth = 79
local augroup = vim.api.nvim_create_augroup("neorg", { clear = true })
vim.api.nvim_create_autocmd("InsertLeave", {
	desc = "Autoformat paragraphs when leaving insert mode",
	group = augroup,
	pattern = "<buffer>", -- Only for this local buffer.
	callback = function()
		require("pencil").autoformat_paragraph(textwidth)
	end,
})
