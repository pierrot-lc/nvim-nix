---@type table<string, vim.lsp.Config>
return {
	cmd = { "marksman", "server" },
	filetypes = { "markodwn", "markdown.mdx" },
	root_markers = { ".marksman.toml" },
}
