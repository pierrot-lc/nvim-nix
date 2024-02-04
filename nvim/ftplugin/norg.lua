-- ========================================================================== --
-- ==                          NEORG SPECIFICS                             == --
-- ========================================================================== --
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.wo.colorcolumn = ""
vim.wo.wrap = false

vim.cmd("call pencil#init({'wrap': 'hard' })")

vim.keymap.set(
	"n",
	"<LocalLeader>c",
	"<cmd>Neorg toggle-concealer<CR>",
	{ desc = "[neorg] Toggle conceiler", buffer = 0 }
)
vim.keymap.set("n", "<LocalLeader>im", "<cmd>Neorg inject-metadata<CR>", { desc = "[neorg] Metadata", buffer = 0 })

if pcall(require, "which-key") then
	require("which-key").register({
		["<LocalLeader>t"] = { name = "+TODO" },
		["<LocalLeader>n"] = { name = "+Notes" },
		["<LocalLeader>i"] = { name = "+Insert" },
		["<LocalLeader>l"] = { name = "+List" },
		["<LocalLeader>m"] = { name = "+Mode" },
	}, { buffer = 0 })
end
