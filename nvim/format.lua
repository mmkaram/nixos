require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		rust = { "rustfmt", lsp_format = "fallback" },
		javascript = { "prettierd", stop_after_first = true },
		javascriptreact = { "prettierd", stop_after_first = true },
		typescriptreact = { "prettierd", stop_after_first = true },
		typescript = { "prettierd" },
		nix = { "alejandra" },
		cpp = { "clang-format" },
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})
