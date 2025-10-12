local function map_key(mode, lhs, rhs, opts)
	local default_opts = { noremap = true, silent = true }
	opts = opts and vim.tbl_extend("force", default_opts, opts) or default_opts
	vim.keymap.set(mode, lhs, rhs, opts)
end

-- General settings
vim.g.mapleader = " "
vim.o.number = true
vim.o.relativenumber = true
vim.o.winborder = "rounded"
vim.o.signcolumn = "yes"
vim.o.swapfile = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.opt.colorcolumn = "100"
vim.o.tabstop = 4 -- Number of spaces in a tab character
vim.o.shiftwidth = 4 -- Number of spaces to use for each step of auto-indent
-- vim.o.expandtab = true -- Use spaces instead of tabs

-- :lua MiniPick.builtin.grep_live({globs={"src/app/layout.tsx"}})

-- mini_pick keymaps
local mini_pick = {
	{ "n", "<leader>ti", ":Pick treesitter<CR>", desc = "Treesitter symbols" },
	{ "n", "<C-i>", ":Pick buffers", desc = "List buffers" },
	{ "n", "<leader>tr", ':Pick lsp scope="references"<CR>', desc = "LSP references" },
	{ "n", "<leader>td", ':Pick lsp scope="definition"<CR>', desc = "LSP definitions" },
	{
		"n",
		"<C-S>s",
		function()
			local current_file = vim.fn.expand("%")
			if current_file == "" then
				vim.notify("No file in current buffer", vim.log.levels.WARN)
				return
			end
			require("mini.pick").builtin.grep_live({ globs = { current_file } })
		end,
		{ desc = "Live grep in current file" },
	},
	{ "n", "<leader>tb", ':Pick lsp scope="workspace_symbol"<CR>', desc = "Workspace symbols" },
	{ "n", "<leader>tv", ':Pick lsp scope="document_symbol"<CR>', desc = "Document symbols" },
	{ "n", "<leader>te", ":Pick explorer<CR>", desc = "File browser" },
	{ "n", "<C-o>", ":Pick files<CR>", desc = "Find files" },
	{ "n", "<C-s>", ":Pick grep_live<CR>", desc = "Live grep" },
	{ "n", "<leader>tm", ":Pick marks<CR>", desc = "List marks" },
	{ "n", "<leader>tp", ":Pick diagnostic<CR>", desc = "List diagnostics" },
	{ "n", '<leader>t"', ":Pick registers<CR>", desc = "List registers" },
}

for _, map in ipairs(mini_pick) do
	map_key(unpack(map))
end

-- Window management
local window_maps = {
	{ "n", "<leader>sh", ":split<CR>", desc = "Horizontal split" },
	{ "n", "<leader>sv", ":vsplit<CR>", desc = "Vertical split" },
	{ "n", "<leader>nh", ":new<CR>", desc = "New horizontal split" },
	{ "n", "<leader>nv", ":vnew<CR>", desc = "New vertical split" },
	{ "n", "<leader>z", ":ZenMode<CR>", desc = "Toggle zen mode" },
	{ "n", "<C-S-k>", ":resize +2<CR>", desc = "Increase window height" },
	{ "n", "<C-S-j>", ":resize -2<CR>", desc = "Decrease window height" },
	{ "n", "<C-S-h>", ":vertical resize -2<CR>", desc = "Decrease window width" },
	{ "n", "<C-S-l>", ":vertical resize +2<CR>", desc = "Increase window width" },
}

for _, map in ipairs(window_maps) do
	map_key(unpack(map))
end

-- Buffer management
local buffer_maps = {
	{ "n", "<tab>", ":bnext<CR>", desc = "Next buffer" },
	{ "n", "<s-tab>", ":bprevious<CR>", desc = "Previous buffer" },
	{ "n", "<leader>sc", ":bd!<CR>", desc = "Close buffer" },
}

for _, map in ipairs(buffer_maps) do
	map_key(unpack(map))
end

-- Git keymaps
local git_maps = {
	{ "n", "<leader>lh", ":Git preview_hunk<CR>", desc = "Preview git hunk" },
	{ "n", "<leader>lb", ":Telescope git_branches<CR>", desc = "Git branches" },
	{ "n", "<leader>lg", ":LazyGit<CR>", desc = "Lazy Git" },
}

for _, map in ipairs(git_maps) do
	map_key(unpack(map))
end

-- LSP keymaps
local lsp_maps = {
	{ "n", "<C-Space>", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "Show hover info" },
	{ "n", "<C-S-Space>", "<cmd>lua vim.lsp.buf.references()<CR>", desc = "Show references" },
	{ "n", "<leader>tn", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename symbol" },
}

for _, map in ipairs(lsp_maps) do
	map_key(unpack(map))
end

-- File explorer keymaps
local file_maps = {
	{ "n", "<leader>o", ":Oil<CR>", desc = "Open file editor" },
	{ "n", "<leader>F", ":Neotree filesystem right toggle<CR>", desc = "Toggle file explorer" },
	{ "n", "<leader>S", ":Neotree document_symbols right toggle<CR>", desc = "Toggle document symbols" },
}

for _, map in ipairs(file_maps) do
	map_key(unpack(map))
end

local trouble_undo = {
	{
		"n",
		"<space>tx",
		function()
			require("trouble").open("diagnostics")
		end,
		desc = "Open LSP issues in Trouble",
	},
	{ "n", "<leader>u", vim.cmd.UndotreeToggle, desc = "Toggle Undotree" },
}

for _, map in ipairs(trouble_undo) do
	map_key(unpack(map))
end

-- Markdown
map_key("n", "<leader>md", ":Markview splitToggle<CR>", { desc = "Toggle markdown view" })
map_key("n", "<leader>mt", ":Markview toggle<CR>", { desc = "Toggle markdown preview" })

-- Flash
map_key({ "n", "x", "o" }, "s", function()
	require("flash").jump()
end, { desc = "Flash Jump" })

-- CodeCompanion
local companion = {
	{ "n", "<leader>aa", ":CodeCompanionChat Toggle<CR>", desc = "Toggle CodeCompanionChat" },
	{ "n", "<leader>an", ":CodeCompanionChat<CR>", desc = "New CodeCompanionChat" },
	{ "n", "<leader>ao", ":CodeCompanionActions<CR>", desc = "New CodeCompanionActions" },
	{ { "n", "v" }, "<leader>ai", ":CodeCompanion<CR>", desc = "Toggle CodeCompanionInline" },
}

for _, map in ipairs(companion) do
	map_key(unpack(map))
end
