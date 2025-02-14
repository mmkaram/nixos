require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		rust = { "rustfmt", lsp_format = "fallback" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
		javascriptreact = { "prettierd", "prettier", stop_after_first = true },
		typescriptreact = { "prettierd", "prettier", stop_after_first = true },
		typescript = { "prettierd", "prettier" },
		nix = { "alejandra" },
		cpp = { "clang-format" },
		prisma = { "prisma-fmt" },
	},
	prisma_fmt = {
		command = "prisma-fmt",
		args = { "--stdin-filename", "$FILENAME" },
		stdin = true,
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})
