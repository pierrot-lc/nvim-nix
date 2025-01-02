---@type table<string, vim.lsp.Config>
return {
	cmd = { "texlab" },
	filetypes = { "bib", "plaintex", "tex" },
	settings = {
		-- https://github.com/latex-lsp/texlab/wiki/Configuration
		texlab = {
			bibtexFormatter = "bibtex-tidy",
			chktex = {
				onOpenAndSave = true,
			},
			formatterLineLength = 0,
			latexindent = {
				modifyLineBreaks = true,
			},
		},
	},
}
