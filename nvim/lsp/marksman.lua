---@type table<string, vim.lsp.Config>
return {
	cmd = { "marksman", "server" },
	filetypes = { "markdown" },
	root_markers = { ".marksman.toml" },
}
