-- ========================================================================== --
-- ==                          NEORG SPECIFICS                             == --
-- ========================================================================== --
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.wo.colorcolumn = ""
vim.wo.wrap = false

vim.keymap.set("n", "<LocalLeader>im", "<cmd>Neorg inject-metadata<CR>", { desc = "[neorg] Metadata", buffer = 0 })
