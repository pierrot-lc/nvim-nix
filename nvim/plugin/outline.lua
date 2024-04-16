require("outline").setup({})

-- Override the default `gO` functionality only when not inside a "help" or
-- "man" page.
local function outline()
	local original_filetypes = { "help", ":Man" }
	if vim.tbl_contains(original_filetypes, vim.bo.filetype) then
		vim.cmd("gO")
	elseif vim.bo.filetype == "qf" then
		-- We're calling `gO` inside the original outline buffer.
		-- Quit the buffer.
		vim.cmd("q")
	else
		-- We're on any other type of buffer. We can call our outline plugin.
		-- Use "!" operator to not change the window focus.
		vim.cmd("Outline!")
	end
end

vim.keymap.set("n", "gO", outline, { desc = "Toggle outline" })
