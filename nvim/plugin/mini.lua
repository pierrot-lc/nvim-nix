require('mini.comment').setup {
  mappings = {
    comment = 'gc',
    comment_line = 'gcc',
    textobject = 'gc',
  },
}

if pcall(require, 'which-key') then
  require('which-key').register {
    ['gc'] = { name = '+Comment' },
  }
end

require('mini.indentscope').setup()

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'help', 'alpha', 'dashboard', 'NvimTree', 'Trouble', 'lazy', 'mason' },
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
})

require("mini.splitjoin").setup({
		mappings = {
				toggle = "gS",
		}
})
