require("kanagawa").setup({
	compile = false,
	transparent = vim.g.transparent_background,
	overrides = function(colors)
		local theme = colors.theme

		local transparent_floats = {
			NormalFloat = { bg = "none" },
			FloatBorder = { bg = "none" },
			FloatTitle = { bg = "none" },
			TelescopeBorder = { bg = "none" },

			-- Save an hlgroup with dark background and dimmed foreground
			-- so that you can use it where your still want darker windows.
			-- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
			NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

			-- Popular plugins that open floats will link to NormalFloat by default;
			-- set their background accordingly if you wish to keep them dark and borderless
			LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
			MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
		}

		return vim.g.transparent_background and transparent_floats or {}
	end,
})

if vim.g.theme == "kanagawa" then
	vim.cmd("colorscheme kanagawa-dragon")
end
