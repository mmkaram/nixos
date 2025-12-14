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

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					vim.env.VIMRUNTIME,
					vim.fn.stdpath("config"),
				},
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

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

-- arduino-cli core update-index
-- arduino-cli core install esp32:esp32
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

local cmp = require("cmp")
cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<Enter>"] = cmp.mapping.confirm({ select = true }),
	}),
})

vim.diagnostic.config({
	virtual_lines = { current_line = true },
	virtual_text = false,
})
vim.lsp.inlay_hint.enable(true)
