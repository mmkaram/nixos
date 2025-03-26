require("telescope").setup({
	pickers = {
		find_files = {
			hidden = true,
		},
	},
})

-- Set leader key
vim.g.mapleader = " "
-- Mapping to open Telescope
vim.keymap.set("n", "<leader>tt", ":Telescope<CR>", { noremap = true, silent = true, desc = "List telescope" })
-- Additional mappings for various Telescope functions
vim.keymap.set(
	"n",
	"<leader>ti",
	":Telescope treesitter<CR>",
	{ noremap = true, silent = true, desc = "List treesitter" }
)
vim.keymap.set("n", "<C-p>", ":Telescope buffers<CR>", { noremap = true, silent = true, desc = "List buffers" })
vim.keymap.set(
	"n",
	"<leader>tr",
	":Telescope lsp_references<CR>",
	{ noremap = true, silent = true, desc = "LSP references" }
)
vim.keymap.set(
	"n",
	"<leader>td",
	":Telescope lsp_definitions<CR>",
	{ noremap = true, silent = true, desc = "LSP definitions" }
)
vim.keymap.set(
	"n",
	"<leader>tf",
	":Telescope current_buffer_fuzzy_find<CR>",
	{ noremap = true, silent = true, desc = "Find document string" }
)
vim.keymap.set(
	"n",
	"<leader>tb",
	":Telescope lsp_dynamic_workspace_symbols<CR>",
	{ noremap = true, silent = true, desc = "Show workspace symbols" }
)
vim.keymap.set(
	"n",
	"<leader>tv",
	":Telescope lsp_document_symbols<CR>",
	{ desc = "Show document symbols", noremap = true, silent = true }
)

-- Key mapping to open the file browser
vim.set.set("n", "<leader>te", ":Telescope file_browser<CR>", { noremap = true, silent = true, desc = "List files" })
vim.keymap.set("n", "<C-o>", ":Telescope find_files<CR>", { noremap = true, silent = true, desc = "Find files" })

-- Marks
vim.keymap.set("n", "<leader>tm", ":Telescope marks<CR>", { noremap = true, silent = true, desc = "List marks" })

-- Search
vim.keymap.set(
	"n",
	"<C-s>",
	":Telescope live_grep<CR>",
	{ noremap = true, silent = true, desc = "Find workspace string" }
)

-- Problems/diagnostics
vim.keymap.set("n", "<leader>tp", "<cmd>Telescope diagnostics<cr>", { desc = "List diagnostics" })

-- registers
vim.keymap.set("n", '<leader>t"', "<cmd>Telescope registers<cr>", { desc = "List registers" })

-- -- LSP rename
vim.keymap.set("n", "<leader>tn", vim.lsp.buf.rename, { desc = "LSP rename" })
