
vim.g.mapleader = " "
  -- Horizontal split
  vim.api.nvim_set_keymap('n', '<Leader>sh', ':split<CR>', { noremap = true, silent = true })

  -- Vertical split
  vim.api.nvim_set_keymap('n', '<Leader>sv', ':vsplit<CR>', { noremap = true, silent = true })

  -- New horizontal split
  vim.api.nvim_set_keymap('n', '<Leader>nh', ':new<CR>', { noremap = true, silent = true })

  -- New vertical split
  vim.api.nvim_set_keymap('n', '<Leader>nv', ':vnew<CR>', { noremap = true, silent = true })


