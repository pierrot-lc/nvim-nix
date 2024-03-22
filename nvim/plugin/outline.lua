require("outline").setup({})
-- Use "!" operator to not change the window focus.
vim.keymap.set("n", "<leader>lo", "<cmd>Outline!<cr>", { desc = "Toggle symbols outline" })
