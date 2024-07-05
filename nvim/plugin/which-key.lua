vim.opt.timeout = true
vim.opt.timeoutlen = 300

require("which-key").setup()

require("which-key").register({
	["<Leader>g"] = { name = "+Others" },
	["<Leader>l"] = { name = "+LSP & Treesitter" },
	["<Leader>t"] = { name = "+Telescope" },
	["<Leader>z"] = { name = "+Tabs" },
	["cr"] = { name = "+LSP" },
})
