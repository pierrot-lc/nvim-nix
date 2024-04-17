local formatters_by_ft = {
	markdown = { "injected" },
	neorg = { "injected" },
}

if vim.fn.executable("jq") == 1 then
	formatters_by_ft.json = { "jq" }
end

if vim.fn.executable("just") == 1 then
	formatters_by_ft.just = { "just" }
end

if vim.fn.executable("stylua") == 1 then
	formatters_by_ft.lua = { "stylua" }
end

if vim.fn.executable("alejandra") == 1 then
	formatters_by_ft.nix = { "alejandra" }
end

if vim.fn.executable("shfmt") == 1 then
	formatters_by_ft.sh = { "shfmt" }
end


require("conform").setup({
	formatters_by_ft = formatters_by_ft,
})

vim.keymap.set("n", "<leader>F", require("conform").format, { desc = "Format" })
