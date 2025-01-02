---@type table<string, vim.lsp.Config>
return {
	cmd = { "ruff", "server" },
	filetypes = { "python" },
	root_markers = { ".ruff.toml", "pyproject.toml", "requirements.txt", "ruff.toml" },
}
