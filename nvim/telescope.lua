local telescope = require('telescope.builtin')

-- Set leader key
vim.g.mapleader = " "  -- Change this to your preferred leader key

-- Mapping to open Telescope
vim.api.nvim_set_keymap('n', '<leader>tt', ':Telescope<CR>', { noremap = true, silent = true })

-- Additional mappings for various Telescope functions
vim.api.nvim_set_keymap('n', '<leader>tb', ':Telescope buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tl', ':Telescope lsp_references<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tf', ':Telescope current_buffer_fuzzy_find<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tF', ':Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tg', ':Telescope grep_string<CR>', { noremap = true, silent = true })

-- Key mapping to open the file browser
vim.api.nvim_set_keymap('n', '<leader>te', ':Telescope file_browser<CR>', { noremap = true, silent = true })
