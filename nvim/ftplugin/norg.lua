-- ========================================================================== --
-- ==                          NEORG SPECIFICS                             == --
-- ========================================================================== --
vim.wo.wrap = true
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2

vim.keymap.set("n", "<LocalLeader>c", ":Neorg toggle-concealer<CR>", { desc = "Toggle conceiler", buffer = 0 })
vim.keymap.set("n", "<LocalLeader>im", ":Neorg inject-metadata<CR>", { desc = "Metadata", buffer = 0 })

if pcall(require, "which-key") then
	require("which-key").register({
		["<LocalLeader>t"] = { name = "+TODO" },
		["<LocalLeader>n"] = { name = "+Notes" },
		["<LocalLeader>i"] = { name = "+Insert" },
		["<LocalLeader>l"] = { name = "+List" },
		["<LocalLeader>m"] = { name = "+Mode" },
	}, { buffer = 0 })
end
