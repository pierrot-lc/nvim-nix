-- ========================================================================== --
-- ==                          LATEX SPECIFICS                             == --
-- ========================================================================== --
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.wo.colorcolumn = vim.g.text_colorcolumn
vim.wo.wrap = false

local textwidth = tonumber(vim.g.text_colorcolumn)
vim.cmd("call pencil#init({'wrap': 'hard', 'textwidth': " .. textwidth .. "})")
