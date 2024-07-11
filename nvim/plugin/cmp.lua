local lspconfig = require("lspconfig")
local lspdefaults = lspconfig.util.default_config
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local cmp = require("cmp")
local luasnip = require("luasnip")

require("gitmoji").setup({
	filetypes = { "gitcommit", "gitrebase", "NeogitCommitMessage" },
})

vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Add completion capabilities to default LSP capabilities.
lspdefaults.capabilities = vim.tbl_deep_extend("force", lspdefaults.capabilities, capabilities)

-- This function is used to check if the cursor is at the beginning of a word.
-- It is used to prevent completion from being triggered when inserting a tab.
local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local kind_icons = {
	Class = "󰠱 ",
	Color = "󰏘 ",
	Constant = "󰏿 ",
	Constructor = " ",
	Enum = " ",
	EnumMember = " ",
	Event = " ",
	Field = "󰇽 ",
	File = "󰈙 ",
	Folder = "󰉋 ",
	Function = "󰊕 ",
	Interface = " ",
	Keyword = "󰌋 ",
	Method = "󰆧 ",
	Module = " ",
	Operator = "󰆕 ",
	Property = "󰜢 ",
	Reference = " ",
	Snippet = " ",
	Struct = " ",
	Text = " ",
	TypeParameter = "󰅲 ",
	Unit = " ",
	Value = "󰎠 ",
	Variable = "󰂡 ",
}
local menu_icons = {
	calc = " ",
	gitmoji = " ",
	luasnip = " ",
	neorg = " ",
	nvim_lsp = "λ ",
	path = " ",
	rg = " ",
	treesitter = " ",
	vimtex = " ",
}


cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	sources = {
		{ name = "calc" },
		{ name = "gitmoji" },
		{ name = "luasnip" },
		{ name = "neorg" },
		{ name = "nvim_lsp", priority = 10 },
		{ name = "path" },
		{ name = "rg", priority = 0 },
		{ name = "treesitter", priority = 5 },
		{ name = "vimtex" },
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	formatting = {
		fields = { "menu", "abbr", "kind" },
		expandable_indicator = true,
		format = function(entry, item)
			item.menu = menu_icons[entry.source.name]
			item.kind = string.format("%s %s", kind_icons[item.kind] or "󰠱 ", item.kind)

			-- Remove duplicate entries from some sources.
			local item_dup = {
				rg = 0,
				treesitter = 0,
			}
			item.dup = item_dup[entry.source.name] or 1

			return item
		end,
	},
	mapping = {
		["<Up>"] = cmp.mapping.select_prev_item(),
		["<Down>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
		["<TAB>"] = cmp.mapping(function(fallback)
			if cmp.visible() and has_words_before() then
				-- We make sure there's a word before the cursor,
				-- otherwise `cmp` could be triggered when we don't want to.
				cmp.select_next_item()
			elseif luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-TAB>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	sorting = {
		priority_weight = 2,
		comparators = {
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.score,
			cmp.config.compare.recently_used,
			cmp.config.compare.locality,
			cmp.config.compare.kind,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
	},
})
