local opts = { noremap = true, silent = true }
function map_key(mode, lhs, rhs, opts)
	-- Set default options
	local default_opts = { noremap = true, silent = true }

	-- If opts is provided, merge it with default_opts
	if opts then
		for k, v in pairs(opts) do
			default_opts[k] = v
		end
	end

	-- Set the keymap
	vim.api.nvim_set_keymap(mode, lhs, rhs, default_opts)
end

vim.cmd("set number relativenumber")

vim.g.mapleader = " "
-- Horizontal split
vim.api.nvim_set_keymap("n", "<Leader>sh", ":split<CR>", { noremap = true, silent = true })
-- Vertical split
vim.api.nvim_set_keymap("n", "<Leader>sv", ":vsplit<CR>", { noremap = true, silent = true })
-- New horizontal split
vim.api.nvim_set_keymap("n", "<Leader>nh", ":new<CR>", { noremap = true, silent = true })
-- New vertical split
vim.api.nvim_set_keymap("n", "<Leader>nv", ":vnew<CR>", { noremap = true, silent = true })

-- fullscreen
map_key("n", "<Leader>f", ":ZenMode<CR>")

-- TODO: broken
-- Resize panes vertically
map_key("n", "<C-S-k>", ":resize +2<CR>")
map_key("n", "<C-S-j>", ":resize -2<CR>")
-- Resize panes horizontally
map_key("n", "<C-S-h>", ":vertical resize -2<CR>")
map_key("n", "<C-S-l>", ":vertical resize +2<CR>")

-- Tabs
map_key("n", "<tab>", ":bnext<CR>")
map_key("n", "<s-tab>", ":bprevious<CR>")

-- close buffers
vim.api.nvim_set_keymap("n", "<Leader>sc", ":bd!<CR>", { noremap = true, silent = true })

-- Git things
vim.api.nvim_set_keymap("n", "<Leader>lh", ":Git preview_hunk<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>lb", ":Telescope git_branches<CR>", opts)

-- Markdown
vim.api.nvim_set_keymap("n", "<Leader>md", ":Markview splitToggle<CR>", opts)

-- LSP
vim.api.nvim_set_keymap("n", "<C-Space>", "<cmd>lua vim.lsp.buf.hover()<CR>", { silent = true, noremap = true })
-- borked
vim.api.nvim_set_keymap("n", "<C-S-Space>", "<cmd>lua vim.lsp.buf.references()<CR>", { silent = true, noremap = true })

-- Oil
vim.api.nvim_set_keymap("n", "<Leader>o", ":Oil<CR>", opts)

-- Neo-Tree
vim.keymap.set("n", "<Leader>F", ":Neotree filesystem right toggle<CR>", opts)
vim.keymap.set("n", "<Leader>S", ":Neotree document_symbols right toggle<CR>", opts)
