local function map_key(mode, lhs, rhs, opts)
	local default_opts = { noremap = true, silent = true }
	opts = opts and vim.tbl_extend("force", default_opts, opts) or default_opts
	vim.keymap.set(mode, lhs, rhs, opts)
end

-- General settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.g.mapleader = " "

-- Telescope configuration
require("telescope").setup({
	pickers = {
		find_files = {
			hidden = true,
		},
	},
})

-- Telescope keymaps
local telescope_maps = {
	{ "n", "<leader>tt", ":Telescope<CR>", desc = "Open Telescope" },
	{ "n", "<leader>ti", ":Telescope treesitter<CR>", desc = "Treesitter symbols" },
	{ "n", "<C-p>", ":Telescope buffers<CR>", desc = "List buffers" },
	{ "n", "<leader>tr", ":Telescope lsp_references<CR>", desc = "LSP references" },
	{ "n", "<leader>td", ":Telescope lsp_definitions<CR>", desc = "LSP definitions" },
	{ "n", "<leader>tf", ":Telescope current_buffer_fuzzy_find<CR>", desc = "Fuzzy find in buffer" },
	{ "n", "<leader>tb", ":Telescope lsp_dynamic_workspace_symbols<CR>", desc = "Workspace symbols" },
	{ "n", "<leader>tv", ":Telescope lsp_document_symbols<CR>", desc = "Document symbols" },
	{ "n", "<leader>te", ":Telescope file_browser<CR>", desc = "File browser" },
	{ "n", "<C-o>", ":Telescope find_files<CR>", desc = "Find files" },
	{ "n", "<leader>tm", ":Telescope marks<CR>", desc = "List marks" },
	{ "n", "<C-s>", ":Telescope live_grep<CR>", desc = "Live grep" },
	{ "n", "<leader>tp", ":Telescope diagnostics<CR>", desc = "List diagnostics" },
	{ "n", '<leader>t"', ":Telescope registers<CR>", desc = "List registers" },
}

for _, map in ipairs(telescope_maps) do
	map_key(table.unpack(map))
end

-- Window management
local window_maps = {
	{ "n", "<leader>sh", ":split<CR>", desc = "Horizontal split" },
	{ "n", "<leader>sv", ":vsplit<CR>", desc = "Vertical split" },
	{ "n", "<leader>nh", ":new<CR>", desc = "New horizontal split" },
	{ "n", "<leader>nv", ":vnew<CR>", desc = "New vertical split" },
	{ "n", "<leader>f", ":ZenMode<CR>", desc = "Toggle zen mode" },
	{ "n", "<C-S-k>", ":resize +2<CR>", desc = "Increase window height" },
	{ "n", "<C-S-j>", ":resize -2<CR>", desc = "Decrease window height" },
	{ "n", "<C-S-h>", ":vertical resize -2<CR>", desc = "Decrease window width" },
	{ "n", "<C-S-l>", ":vertical resize +2<CR>", desc = "Increase window width" },
}

for _, map in ipairs(window_maps) do
	map_key(table.unpack(map))
end

-- Buffer management
local buffer_maps = {
	{ "n", "<tab>", ":bnext<CR>", desc = "Next buffer" },
	{ "n", "<s-tab>", ":bprevious<CR>", desc = "Previous buffer" },
	{ "n", "<leader>sc", ":bd!<CR>", desc = "Close buffer" },
}

for _, map in ipairs(buffer_maps) do
	map_key(table.unpack(map))
end

-- Git keymaps
local git_maps = {
	{ "n", "<leader>lh", ":Git preview_hunk<CR>", desc = "Preview git hunk" },
	{ "n", "<leader>lb", ":Telescope git_branches<CR>", desc = "Git branches" },
}

for _, map in ipairs(git_maps) do
	map_key(table.unpack(map))
end

-- LSP keymaps
local lsp_maps = {
	{ "n", "<C-Space>", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "Show hover info" },
	{ "n", "<C-S-Space>", "<cmd>lua vim.lsp.buf.references()<CR>", desc = "Show references" },
	{ "n", "<leader>tn", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename symbol" },
}

for _, map in ipairs(lsp_maps) do
	map_key(table.unpack(map))
end

-- File explorer keymaps
local file_maps = {
	{ "n", "<leader>o", ":Oil<CR>", desc = "Open file explorer" },
	{ "n", "<leader>F", ":Neotree filesystem right toggle<CR>", desc = "Toggle file explorer" },
	{ "n", "<leader>S", ":Neotree document_symbols right toggle<CR>", desc = "Toggle document symbols" },
}

for _, map in ipairs(file_maps) do
	map_key(table.unpack(map))
end

-- Markdown
map_key("n", "<leader>md", ":Markview splitToggle<CR>", { desc = "Toggle markdown view" })
