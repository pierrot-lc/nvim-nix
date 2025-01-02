--- Find LSP-specifics configs here: https://github.com/neovim/nvim-lspconfig/tree/master/lua/lspconfig/configs
vim.diagnostic.config({ update_in_insert = false })

vim.lsp.config("*", {
	root_markers = { ".git" },
})

-- Enable LSPs if their executables are found.
local lspExecutables = {
	basedpyright = "basedpyright",
	bashls = "bash-language-server",
	gleam = "gleam",
	lua_ls = "lua-language-server",
	marksman = "marksman",
	nixd = "nixd",
	ruff = "ruff",
	texlab = "texlab",
	tinymist = "tinymist",
}
for lspName, executableName in pairs(lspExecutables) do
	if vim.fn.executable(executableName) == 1 then
		vim.lsp.enable(lspName)
	end
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
