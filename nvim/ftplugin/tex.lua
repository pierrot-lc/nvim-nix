-- ========================================================================== --
-- ==                          LATEX SPECIFICS                             == --
-- ========================================================================== --
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.wo.colorcolumn = ""
vim.wo.wrap = false

vim.cmd("call pencil#init({'wrap': 'hard', 'textwidth': '100'})")
vim.keymap.set("n", "<localleader>p", "<cmd>PencilToggle<cr>", { desc = "[pencil] Toggle", buffer = 0 })
