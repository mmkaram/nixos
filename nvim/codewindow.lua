local codewindow = require('codewindow')
codewindow.setup()
vim.g.mapleader = " "
codewindow.apply_default_keybinds()
-- vim.api.nvim_set_keymap('n', '<Leader>mm', codewindow.toggle_minimap(), {noremap = true, silent = true})
-- codewindow.toggle_minimap()
