require("conform").setup({
	formatters = {
		prisma_fmt = {
			command = "prisma-fmt",
			args = { "format" },
			stdin = true,
		},
	},
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "black" },
		rust = { "rustfmt", lsp_format = "fallback" },
		javascript = { "prettierd", stop_after_first = true },
		javascriptreact = { "prettierd", stop_after_first = true },
		typescriptreact = { "prettierd", stop_after_first = true },
		typescript = { "prettierd" },
		nix = { "nixfmt" },
		cpp = { "clang-format" },
		prisma = { "prisma_fmt" },
		svelte = { "prettierd" },
	},
})

vim.api.nvim_create_user_command("W", function()
	-- Run format first, then write
	require("conform").format({ async = false }) -- synchronous formatting
	vim.cmd.write() -- write to disk
end, {})

vim.cmd("cnoreabbrev <expr> w getline('.') == ':w' ? ':W' : 'w'")

vim.keymap.set("n", "<leader>w", function()
	vim.cmd.write() -- write without formatting
end, { desc = "Save without formatting" })
