---@type table<string, vim.lsp.Config>
return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = {
		".luacheckrc",
		".luarc.json",
		".luarc.jsonc",
		".stylua.toml",
		"selene.toml",
		"selene.yml",
		"stylua.toml",
	},
	settings = {
		-- https://luals.github.io/wiki/settings/
		Lua = {
			workspace = {
				-- Remove annoying popup when editing standalone lua files.
				checkthirdparty = "Disable",
			},
			format = {
				-- Handled by stylua.
				enable = false,
			},
		},
	},
}
