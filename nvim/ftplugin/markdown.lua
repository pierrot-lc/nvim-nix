-- ========================================================================== --
-- ==                          MARKDOWN SPECIFICS                          == --
-- ========================================================================== --
vim.wo.wrap = true
vim.keymap.set({ "n", "o", "x" }, "k", "gk", { desc = "Up on wrapped lines", buffer = 0 })
vim.keymap.set({ "n", "o", "x" }, "j", "gj", { desc = "Down on wrapped lines", buffer = 0 })
