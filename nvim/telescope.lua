local telescope = require('telescope.builtin')

-- Set leader key
vim.g.mapleader = " "
	-- Mapping to open Telescope
	vim.api.nvim_set_keymap('n', '<leader>tt', ':Telescope<CR>', { noremap = true, silent = true })
	-- Additional mappings for various Telescope functions
	vim.api.nvim_set_keymap('n', '<leader>ti', ':Telescope treesitter<CR>', { noremap = true, silent = true })
	vim.api.nvim_set_keymap('n', '<C-p>', ':Telescope buffers<CR>', { noremap = true, silent = true })
	vim.api.nvim_set_keymap('n', '<leader>tr', ':Telescope lsp_references<CR>', { noremap = true, silent = true })
	vim.api.nvim_set_keymap('n', '<leader>td', ':Telescope lsp_definitions<CR>', { noremap = true, silent = true })
	vim.api.nvim_set_keymap('n', '<leader>tf', ':Telescope current_buffer_fuzzy_find<CR>', { noremap = true, silent = true })
	vim.api.nvim_set_keymap('n', '<leader>tF', ':Telescope file_browser<CR>', { noremap = true, silent = true })
	vim.api.nvim_set_keymap('n', '<leader>tg', ':Telescope grep_string<CR>', { noremap = true, silent = true })
	vim.api.nvim_set_keymap('n', '<leader>tb', ':Telescope lsp_dynamic_workspace_symbols<CR>', { noremap = true, silent = true })
	vim.api.nvim_set_keymap('n', '<leader>tv', ':Telescope lsp_document_symbols<CR>', { desc = 'Show document symbols', noremap = true, silent = true })

	-- Key mapping to open the file browser
	vim.api.nvim_set_keymap('n', '<leader>te', ':Telescope file_browser<CR>', { noremap = true, silent = true })
	vim.api.nvim_set_keymap('n', '<C-S-o>', ':Telescope file_browser<CR>', { noremap = true, silent = true })
	vim.api.nvim_set_keymap('n', '<C-o>', ':Telescope find_files<CR>', { noremap = true, silent = true })

	-- Marks
	vim.api.nvim_set_keymap('n', '<leader>tm', ':Telescope marks<CR>', { noremap = true, silent = true })

	-- Search
	vim.api.nvim_set_keymap('n', '<leader>ts', ':Telescope live_grep<CR>', { noremap = true, silent = true })

	-- Problems/diagnostics
	vim.api.nvim_set_keymap('n', '<leader>tp', '<cmd>Telescope diagnostics<cr>', { desc = 'List diagnostics' })

	-- registers
	vim.api.nvim_set_keymap('n', '<leader>t"', '<cmd>Telescope registers<cr>', { desc = 'List registers' })

-- -- LSP rename
vim.keymap.set("n", "<leader>tn", vim.lsp.buf.rename, { desc = "LSP rename" })
-- require('telescope').setup({
--   extensions = {
--     ['ui-select'] = {
--       require('telescope.themes').get_dropdown()
--     }
--   }
-- })
--
-- require('telescope').load_extension('ui-select')
--
-- vim.keymap.set('n', '<leader>tn', function()
--   return ":IncRename " .. vim.fn.expand("<cword>")
-- end, { expr = true })
