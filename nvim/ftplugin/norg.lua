-- ========================================================================== --
-- ==                          NEORG SPECIFICS                             == --
-- ========================================================================== --
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.wo.colorcolumn = ""
vim.wo.wrap = false

vim.keymap.set("n", "<LocalLeader>im", "<cmd>Neorg inject-metadata<CR>", { desc = "[neorg] Metadata", buffer = 0 })

if pcall(require, "which-key") then
	require("which-key").add({
		{ "<LocalLeader>t", group = "TODO", buffer = 0 },
		{ "<LocalLeader>n", group = "Notes", buffer = 0 },
		{ "<LocalLeader>i", group = "Insert", buffer = 0 },
		{ "<LocalLeader>l", group = "List", buffer = 0 },
		{ "<LocalLeader>m", group = "Mode", buffer = 0 },
	})
end
