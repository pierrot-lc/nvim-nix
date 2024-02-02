vim.opt.timeout = true
vim.opt.timeoutlen = 300

require("which-key").setup()

require("which-key").register({
	["<Leader>l"] = { name = "+LSP" },
	["<Leader>t"] = { name = "+Telescope" },
})
