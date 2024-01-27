require("nvim-treesitter.configs").setup({
	-- Highlight based on treesitter.
	highlight = { enable = true },
	-- Indentation based on treesitter (use `=` operator).
	ident = { enable = true },
	-- Incremental selection in the parsed tree.
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gn",
			node_incremental = "<TAB>",
			node_decremental = "<S-TAB>",
			scope_incremental = false,
		},
	},
	-- Refactor modules.
	refactor = {
		highlight_definitions = {
			enable = true,
			clear_on_cursor_move = true,
		},
		highlight_current_scope = { enable = false },
		smart_rename = {
			enable = false,
			keymaps = { smart_rename = "gR" },
		},
	},
	-- Manipulate text-objects.
	textobjects = {
		-- Adding text-objects to select operators.
		select = {
			enable = true,
			lookahead = true,
			include_surrounding_whitespace = true,
			keymaps = {
				["af"] = { query = "@function.outer", desc = "Select function outer" },
				["if"] = { query = "@function.inner", desc = "Select function inner" },
				["ac"] = { query = "@comment.outer", desc = "Select comment outer" },
				["ic"] = { query = "@comment.inner", desc = "Select comment inner" },
				["al"] = { query = "@loop.outer", desc = "Select loop outer" },
				["il"] = { query = "@loop.inner", desc = "Select loop innter" },
				["ai"] = { query = "@conditional.outer", desc = "Select conditional outer" },
				["ii"] = { query = "@conditional.inner", desc = "Select conditional inner" },
				["ap"] = { query = "@parameter.outer", desc = "Select parameter outer" },
				["ai"] = { query = "@parameter.inner", desc = "Select parameter inner" },
			},
		},
		-- Swap two text-objects.
		swap = {
			enable = true,
			swap_next = {
				["<Leader>ls"] = { query = "@parameter.inner", desc = "Swap with the next parameter" },
			},
			swap_previous = {
				["<Leader>lS"] = { query = "@parameter.inner", desc = "Swap with the previous parameter" },
			},
		},
		-- Move around text-objects.
		move = {
			enable = true,
			set_jumps = true,
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = { query = "@class.outer", desc = "Next class start" },
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
		-- Peek definition code using built-in LSP.
		lsp_interop = {
			enable = true,
			border = "none",
			peek_definition_code = {
				["<Leader>lf"] = { query = "@function.outer", desc = "Show function definition" },
				["<Leader>lc"] = { query = "@class.outer", desc = "Show class definition" },
			},
		},
	},
})

require("treesitter-context").setup({
	enable = true,
	max_lines = 1,
})

-- Use treesitter expressions for folds.
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
