-- ========================================================================== --
-- ==                          NEORG SPECIFICS                             == --
-- ========================================================================== --
vim.bo.formatoptions = string.gsub(vim.bo.formatoptions, "t", "")
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.wo.colorcolumn = ""
vim.wo.wrap = false

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
