---@type table<string, vim.lsp.Config>
return {
	cmd = { "ty", "server" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "requirements.txt", "ty.toml" },
	settings = {
		ty = {
			disableLanguageServices = true, -- Typecheck only.
		},
	},
}
