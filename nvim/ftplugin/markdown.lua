-- ========================================================================== --
-- ==                          MARKDOWN SPECIFICS                          == --
-- ========================================================================== --
vim.wo.colorcolumn = ""
vim.wo.wrap = false

vim.cmd([[
	call pencil#init({
		\ "wrap": "hard",
		\ "conceallevel": 2,
		\ "concealcursor": "",
		\})
]])
vim.keymap.set("n", "<localleader>p", "<cmd>PencilToggle<cr>", { desc = "[pencil] Toggle", buffer = 0 })
