-- ========================================================================== --
-- ==                           OPTIONS SETTINGS                           == --
-- ========================================================================== --
vim.g.loaded_netrw = 1 -- Deactivate netrw file manager (handled by a plugin).
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = " " -- Redefine leader key.
vim.g.maplocalleader = "," -- Redefine local leader key.
vim.opt.breakindent = true -- Conserve indentation of virtual wrapped lines.
vim.opt.colorcolumn = "88" -- Show a column at 88 characters (`black` configuration).
vim.opt.cursorline = true -- Highlight cursor line.
vim.opt.expandtab = true -- Whether or not we want to transform tabs to spaces.
vim.opt.foldlevelstart = 99 -- Do not fold by default when opening a file.
vim.opt.hlsearch = true -- Set highlight on search.
vim.opt.ignorecase = true -- Case insensitive searching...
vim.opt.inccommand = "split"
vim.opt.list = true -- Show invisible spaces.
vim.opt.listchars:append({
	tab = "» ",
	extends = "›",
	precedes = "‹",
	trail = "·",
	nbsp = "·",
	-- eol = "↵"
})
vim.opt.mouse = "a" -- Enable mouse for all modes.
vim.opt.scrolloff = 5 -- Offset before scrolling.
vim.opt.shiftwidth = 4 -- Amount of spaces are used to indent a line.
vim.opt.smartcase = true -- ...unless there is capital or /C in search.
vim.opt.smoothscroll = true -- Scroll naturally on softwrapped lines.
vim.opt.splitbelow = true -- Choose where splits are going.
vim.opt.splitright = true
vim.opt.swapfile = false -- Deactivate swap file.
vim.opt.tabstop = 4 -- Amount of spaces a 'tab' character occupy.
vim.opt.termguicolors = true -- Enable 24-bit RGB color in the TUI.
vim.opt.undofile = true -- Save undo history.
vim.opt.updatetime = 1000 -- Decrease update time (default is 4000).
vim.opt.virtualedit = "block"
vim.opt.wrap = false -- Whether or not we want to wrap long lines.
vim.wo.number = true -- Show line numbers default.
vim.wo.relativenumber = false
vim.wo.signcolumn = "yes" -- Always shows the sign column (where we put gitsigns and warnings).
