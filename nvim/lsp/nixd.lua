---@type table<string, vim.lsp.Config>
return {
	cmd = { "nixd" },
	filetypes = { "nix" },
	root_markers = { "flake.nix" },
}
