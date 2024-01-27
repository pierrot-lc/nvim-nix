local spider = require('spider')
local spider_jump = function(move)
  local jump_function = function()
    spider.motion(move)
  end
  return jump_function
end
vim.keymap.set('n', 'w', spider_jump('w'), { desc = 'Spider-w' })
vim.keymap.set('n', 'e', spider_jump('e'), { desc = 'Spider-e' })
vim.keymap.set('n', 'b', spider_jump('b'), { desc = 'Spider-b' })
vim.keymap.set('n', 'ge', spider_jump('ge'), { desc = 'Spider-ge' })

local augend = require('dial.augend')
require('dial.config').augends:register_group {
  default = {
    augend.integer.alias.decimal,
    augend.integer.alias.hex,
    augend.date.alias['%Y/%m/%d'],
    augend.constant.alias.alpha,
    augend.constant.alias.Alpha,
    augend.constant.alias.bool,
    augend.constant.new { elements = { 'True', 'False' } },
  },
}
vim.api.nvim_set_keymap('n', '<C-a>', require('dial.map').inc_normal(), { noremap = true })
vim.api.nvim_set_keymap('n', '<C-x>', require('dial.map').dec_normal(), { noremap = true })

require('outline').setup {}
-- Use "!" operator to not change the window focus.
vim.keymap.set('n', '<leader>lo', '<cmd>Outline!<cr>', { desc = 'Toggle symbols outline' })

require('nvim-autopairs').setup()

-- If you want insert `(` after select function or method item.
local ok, cmp = pcall(require, 'cmp')
if ok then
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
end

require('conform').setup {
  formatters_by_ft = {
    lua = { 'stylua' },
    python = { 'isort' },
    sh = { 'shfmt' },
    json = { 'jq' },
    latex = { 'latexindent' },
  },
}

vim.keymap.set('n', '<leader>F', require('conform').format, { desc = 'Format' })

require('copilot').setup {
  filetypes = {
    ['*'] = true, -- Enable for all filetypes.
  },
  suggestion = {
    enabled = true,
    auto_trigger = false, -- Start suggesting as soon as you start typing.
    keymap = {
      accept = '<M-h>',
      accept_word = '<M-l>',
      accept_line = false,
      next = '<M-k>',
      prev = '<M-j>',
      dismiss = false,
    },
  },
  panel = {
    enabled = false,
  },
}

local leap_jump = function()
  require('leap').leap { target_windows = { vim.fn.win_getid() } }
end

vim.keymap.set('n', '<leader>s', leap_jump, { desc = 'Leap jump' })

require('neogit').setup()

require('lint').linters_by_ft = {
  markdown = { 'markdownlint', 'proselint' },
  norg = { 'proselint' },
  sh = { 'shellcheck' },
  yaml = { 'yamllint' },
}

vim.diagnostic.config { update_in_insert = false }

vim.api.nvim_create_autocmd({
  'BufWritePost',
  'BufReadPost',
}, {
  callback = function()
    require('lint').try_lint()
  end,
})

require('nvim-rooter').setup { manual = true }

require('nvim-surround').setup {}

vim.opt.foldcolumn = '0'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
require('ufo').setup {
  provider_selector = function(bufnr, filetype, buftype)
    return { 'treesitter', 'indent' }
  end,
}

require('todo-comments').setup()

require('toggleterm').setup {
  open_mapping = '<C-g>',
  direction = 'float',
  shade_terminals = true,
}
