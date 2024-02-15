local lspconfig = require("lspconfig")

vim.diagnostic.config({ update_in_insert = false })

-- Load LSP servers.
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
lspconfig["ruff_lsp"].setup({
	init_options = {
		settings = {
			args = { "--ignore", "E501" },
		},
	},
})
lspconfig["lua_ls"].setup({
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using
				-- (most likely LuaJIT in the case of Neovim).
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global.
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
				-- Remove annoying popup when editing standalone lua files.
				checkThirdParty = false,
			},
			telemetry = {
				enable = true, -- That's fine.
			},
			format = {
				enable = false,
			},
		},
	},
})
lspconfig["texlab"].setup({
	auxDirectory = ".",
	bibtexFormatter = "texlab",
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
		modifyLineBreaks = false,
	},
})
lspconfig["bashls"].setup({})
lspconfig["marksman"].setup({})
lspconfig["nil_ls"].setup({})

-- Toggle diagnostics.
local show_diagnostics = true
local toggle_diagnostics = function()
	show_diagnostics = not show_diagnostics
	if show_diagnostics then
		vim.diagnostic.enable()
		print("Diagnostics activated.")
	else
		vim.diagnostic.disable()
		print("Diagnostics hidden.")
	end
end
vim.keymap.set("n", "<leader>ld", toggle_diagnostics, { desc = "Toggle diagnostics" })

-- Bind the `lsp_signature` to the LSP servers.
-- This has to be called after the setup of LSPs.
local signature_opts = {
	bind = true,
	floating_window = true,
	handler_opts = { border = "rounded" },
	hint_enable = false,
	wrap = false,
	hi_parameter = "Search",
}
require("lsp_signature").setup(signature_opts)

-- LSP keymappings.
vim.keymap.set("n", "gl", function()
	return vim.diagnostic.open_float(nil, { focus = false, border = "rounded" })
end, { desc = "Show diagnostics" })
vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { desc = "Show signature" })

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer.
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local bufnr = ev.buf
		local client = vim.lsp.get_client_by_id(ev.data.client_id)

		if client == nil then
			print("No client attached to buffer " .. bufnr)
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

		if client.server_capabilities.codeActionProvider then
			vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Show code actions", buffer = bufnr })
		end

		if client.server_capabilities.documentFormattingProvider then
			vim.keymap.set("n", "<space>lF", function()
				vim.lsp.buf.format({ async = true })
			end, { desc = "Format", buffer = bufnr })
		end

		if client.server_capabilities.documentRangeFormattingProvider then
			vim.keymap.set("v", "<space>lF", function()
				vim.lsp.buf.range_formatting({ async = true })
			end, { desc = "Format", buffer = bufnr })
		end

		if client.server_capabilities.documentHighlightProvider then
			vim.keymap.set("n", "<leader>lh", vim.lsp.buf.document_highlight, { desc = "Highlight", buffer = bufnr })
			vim.keymap.set(
				"n",
				"<leader>lH",
				vim.lsp.buf.clear_references,
				{ desc = "Clear highlight", buffer = bufnr }
			)
		end

		if client.server_capabilities.signatureHelpProvider then
			vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help, { desc = "Show signature", buffer = bufnr })
		end

		if client.server_capabilities.hoverProvider then
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover", buffer = bufnr })
		end

		if client.server_capabilities.implementationProvider then
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation", buffer = bufnr })
		end

		-- Rename.
		if client.server_capabilities.renameProvider then
			vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename symbol", buffer = bufnr })
		end

		-- list workspace.
		if client.server_capabilities.workspaceSymbolProvider then
			vim.keymap.set(
				"n",
				"<leader>lW",
				vim.lsp.buf.workspace_symbol,
				{ desc = "List workspace symbols", buffer = bufnr }
			)
		end
	end,
})

require("fidget").setup({
	-- window = { blend = 0 },
})

require("neodev").setup()

require("outline").setup({})
-- Use "!" operator to not change the window focus.
vim.keymap.set("n", "<leader>lo", "<cmd>Outline!<cr>", { desc = "Toggle symbols outline" })
