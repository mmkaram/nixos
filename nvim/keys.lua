vim.g.mapleader = " "
	-- Horizontal split
	vim.api.nvim_set_keymap('n', '<Leader>sh', ':split<CR>', { noremap = true, silent = true })
	-- Vertical split
	vim.api.nvim_set_keymap('n', '<Leader>sv', ':vsplit<CR>', { noremap = true, silent = true })
	-- New horizontal split
	vim.api.nvim_set_keymap('n', '<Leader>nh', ':new<CR>', { noremap = true, silent = true })
	-- New vertical split
	vim.api.nvim_set_keymap('n', '<Leader>nv', ':vnew<CR>', { noremap = true, silent = true })

	-- fullscreen
	vim.api.nvim_set_keymap('n', '<Leader>f', ':ZenMode<CR>', {noremap = true, silent = true})

	-- pane movement
	vim.api.nvim_set_keymap('n', '<c-k>', ':wincmd k<CR>', { noremap = true, silent = true })
	vim.api.nvim_set_keymap('n', '<c-j>', ':wincmd j<CR>',{ noremap = true, silent = true })
	vim.api.nvim_set_keymap('n', '<c-h>', ':wincmd h<CR>',{ noremap = true, silent = true })
	vim.api.nvim_set_keymap('n', '<c-l>', ':wincmd l<CR>', { noremap = true, silent = true })

	-- close buffers
	vim.api.nvim_set_keymap('n', '<c-w>', ':bd<CR>', { noremap = true, silent = true})
	
	-- preview hunk
	vim.api.nvim_set_keymap('n', '<Leader>lh', ':Git preview_hunk<CR>', { noremap = true, silent = true })
