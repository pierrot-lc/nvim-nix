vim.bo.textwidth = 100

vim.keymap.set("n", "<LocalLeader>f", require("python-tools").puppeteer, { desc = "Puppeteer", buffer = 0 })
vim.keymap.set("n", '<LocalLeader>"', require("python-tools").insert_docstrings, { desc = "Doc-string", buffer = 0 })
