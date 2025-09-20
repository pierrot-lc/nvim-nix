---@type table<string, vim.lsp.Config>
return {
	cmd = { "basedpyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "requirements.txt" },
	settings = {
		-- https://docs.basedpyright.com/latest/configuration/language-server-settings/
		basedpyright = {
			disableOrganizeImports = true,
			analysis = { typeCheckingMode = "off" },
		},
	},
}
