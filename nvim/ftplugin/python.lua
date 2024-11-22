vim.bo.textwidth = 88

vim.keymap.set("n", "<LocalLeader>f", require("puppeteer").puppeteer, { desc = "Puppeteer", buffer = 0 })
