require("nvim-treesitter-textobjects").setup({
	select = {
		lookahead = true,
	},
})

local treesitter_setup = function()
	vim.treesitter.start()
	vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
	vim.wo[0][0].foldmethod = "expr"
	vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"

	local select = function(query)
		return function()
			require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
		end
	end
	vim.keymap.set({ "x", "o" }, "ac", select("@comment.outer"))
	vim.keymap.set({ "x", "o" }, "ic", select("@comment.inner"))
	vim.keymap.set({ "x", "o" }, "ai", select("@conditional.outer"))
	vim.keymap.set({ "x", "o" }, "ii", select("@conditional.inner"))
	vim.keymap.set({ "x", "o" }, "af", select("@function.outer"))
	vim.keymap.set({ "x", "o" }, "if", select("@function.inner"))
	vim.keymap.set({ "x", "o" }, "al", select("@loop.outer"))
	vim.keymap.set({ "x", "o" }, "il", select("@loop.inner"))
	vim.keymap.set({ "x", "o" }, "aa", select("@parameter.outer"))
	vim.keymap.set({ "x", "o" }, "ia", select("@parameter.inner"))

	local swap_next = function(query)
		return function()
			require("nvim-treesitter-textobjects.swap").swap_next(query)
		end
	end
	local swap_previous = function(query)
		return function()
			require("nvim-treesitter-textobjects.swap").swap_previous(query)
		end
	end
	vim.keymap.set({ "n" }, "<Leader>lp", swap_next("@parameter.inner"), { desc = "Swap next" })
	vim.keymap.set({ "n" }, "<Leader>lP", swap_previous("@parameter.inner"), { desc = "Swap previous" })
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"bash",
		"gleam",
		"just",
		"lua",
		"markdown",
		"nix",
		"python",
		"tex",
		"typst",
	},
	callback = treesitter_setup,
})
vim.keymap.set({ "n" }, "<leader>lt", treesitter_setup, { desc = "Start treesitter" })
