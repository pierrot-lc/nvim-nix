local lspconfig = require("lspconfig")

vim.diagnostic.config({ update_in_insert = false })

-- Load LSP servers. Only load them if they're available.
if vim.fn.executable("pylsp") == 1 then
	lspconfig["pylsp"].setup({
		settings = {
			pylsp = {
				plugins = {
					preload = { enabled = true },
					autopep8 = { enabled = false },
					flake8 = { enabled = false },
					pycodestyle = { enabled = false },
					pydocstyle = { enabled = false },
					mccabe = { enabled = false },
					yapf = { enabled = false },
					pylint = { enabled = false },
					pyflakes = { enabled = false },
				},
			},
		},
	})
end

if vim.fn.executable("ruff") == 1 then
	lspconfig["ruff"].setup({})
end

if vim.fn.executable("basedpyright") then
	lspconfig["basedpyright"].setup({
		settings = {
			-- See https://docs.basedpyright.com/latest/configuration/language-server-settings/.
			basedpyright = {
				disableOrganizeImports = true,
			},
		},
	})
end

if vim.fn.executable("texlab") == 1 then
	lspconfig["texlab"].setup({
		auxDirectory = ".",
		bibtexFormatter = "bibtex-tidy",
		build = {
			executable = "latexmk",
			forwardSearchAfter = false,
			onSave = true,
		},
		chktex = {
			onEdit = false,
			onOpenAndSave = true,
		},
		diagnosticsDelay = 300,
		formatterLineLength = 0,
		latexFormatter = "latexindent",
		latexindent = {
			modifyLineBreaks = true,
		},
	})
end

if vim.fn.executable("bash-language-server") == 1 then
	lspconfig["bashls"].setup({})
end

if vim.fn.executable("marksman") == 1 then
	lspconfig["marksman"].setup({})
end

if vim.fn.executable("tinymist") == 1 then
	lspconfig["tinymist"].setup({
		settings = {
			formatterMode = "typstyle",
		},
	})
end

if vim.fn.executable("nixd") == 1 then
	lspconfig["nixd"].setup({})
end

if vim.fn.executable("gleam") == 1 then
	lspconfig["gleam"].setup({})
end

-- LSP keymappings, triggered when the language server attaches to a buffer.
local function on_attach(ev)
	local bufnr = ev.buf
	local client = vim.lsp.get_client_by_id(ev.data.client_id)

	if client == nil then
		vim.notify("No client attached to buffer " .. bufnr, vim.log.levels.ERROR)
		return
	end

	if client.server_capabilities.completionProvider then
		-- Enable completion triggered by <c-x><c-o>.
		vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
	end

	if client.server_capabilities.definitionProvider then
		vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition", buffer = bufnr })
	end

	if client.server_capabilities.declarationProvider then
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration", buffer = bufnr })
	end

	if client.server_capabilities.documentRangeFormattingProvider then
		vim.keymap.set("v", "<leader>lf", function()
			vim.lsp.buf.range_formatting({ async = true })
		end, { desc = "Format", buffer = bufnr })
	end

	if client.server_capabilities.signatureHelpProvider then
		vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { desc = "Show signature", buffer = bufnr })
	end

	if client.server_capabilities.implementationProvider then
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation", buffer = bufnr })
	end

	local signature_opts = {
		handler_opts = { border = "rounded" },
		hint_enable = false,
		wrap = false,
		hi_parameter = "Search",
	}
	require("lsp_signature").on_attach(signature_opts, bufnr)
end

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer.
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = on_attach,
})

-- Was the default momentarily. Maybe will be the defaults later on.
vim.keymap.set("n", "crr", vim.lsp.buf.code_action, { desc = "Code actions" })
vim.keymap.set("n", "crn", vim.lsp.buf.rename, { desc = "Code actions" })

-- These keybindings are presents for all buffers.
vim.keymap.set("n", "<leader>lf", function()
	vim.lsp.buf.format()
	require("conform").format()
end, { desc = "Format" })

vim.keymap.set("n", "gl", function()
	return vim.diagnostic.open_float(nil, { focus = false, border = "rounded" })
end, { desc = "Show diagnostics" })

vim.keymap.set("n", "<leader>ld", function()
	return vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostics" })
