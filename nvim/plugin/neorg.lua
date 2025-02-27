require("neorg").setup({
	load = {
		-- Loads default behaviour.
		["core.defaults"] = {},
		-- Adds pretty icons to your documents.
		["core.concealer"] = {},
		-- Manages Neorg workspaces.
		["core.dirman"] = {
			config = {
				workspaces = {
					notes = "~/notes/",
				},
			},
		},
		-- Add completion support.
		-- ["core.completion"] = {
		-- 	config = {
		-- 		engine = "nvim-cmp",
		-- 	},
		-- },
		-- Make any Norg file presentable.
		-- Use the `:Neorg presenter start` command.
		["core.presenter"] = {
			config = {
				zen_mode = "zen-mode",
			},
		},
		["core.export"] = {},
		-- Do not update date until https://github.com/nvim-neorg/neorg/issues/1579 fixed.
		["core.esupports.metagen"] = { config = { update_date = false } },
	},
})

-- Command for quick access to the journal entry.
vim.api.nvim_create_user_command("Journal", "Neorg journal today", { desc = "Open today journal" })
