vim.lsp.inlay_hint.enable(true)

vim.lsp.config("rust_analyzer", {
	settings = {
		["rust-analyzer"] = {
			diagnostics = {
				enable = false,
			},
			inlayHints = {
				parameterHints = {
					enable = true,
				},
				typeHints = {
					enable = true,
				},
			},
		},
	},
})

vim.lsp.config("arduino_language_server", {
	cmd = {
		"arduino-language-server",
		"-cli-config",
		"/home/dd0k/.arduino15/arduino-cli.yaml",
		"-cli",
		"arduino-cli",
		"-clangd",
		"clangd",
		"-fqbn",
		"esp32:esp32:esp32", -- Fully Qualified Board Name
	},
	filetypes = { "arduino" },
})

vim.lsp.enable({
	"lua_ls",
	"tinymist",
	"svelte",
	"prismals",
	"nil_ls",
	"hls",
	"clangd",
	"pyright",
	"ts_ls",
	"tailwindcss",
	"arduino_language_server",
	"rust_analyzer",
})

local cmp = require("cmp")
cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<Enter>"] = cmp.mapping.confirm({ select = true }),
	}),
})

vim.diagnostic.config({
	virtual_text = false,
})
