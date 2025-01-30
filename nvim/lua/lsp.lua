--- Find LSP-specifics configs here: https://github.com/neovim/nvim-lspconfig/tree/master/lua/lspconfig/configs
vim.diagnostic.config({ update_in_insert = false })

vim.lsp.config("*", {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
	root_markers = { ".git" },
})

-- Enable LSPs if their executables are found.
local lspExecutables = {
	basedpyright = "basedpyright",
	bashls = "bash-language-server",
	clangd = "clangd",
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
	local client = vim.lsp.get_client_by_id(ev.data.client_id)
	if client == nil then
		vim.notify("No client attached to buffer " .. ev.buf, vim.log.levels.ERROR)
		return
	end

	-- A bunch of keymappings are now setup by default. See :h lsp-defaults
	vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, { autotrigger = false })
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition", buffer = ev.buf })
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration", buffer = ev.buf })
end

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer.
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = on_attach,
})

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
