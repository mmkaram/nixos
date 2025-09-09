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

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Set up nvim-cmp
local cmp = require("cmp")
cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<Enter>"] = cmp.mapping.confirm({ select = true }),
	}),
})

vim.diagnostic.config({
	-- TODO: current_line doesn't work, maybe update
	virtual_lines = { only_current_line = true }, -- show virtual lines only on the current line
	virtual_text = false,
})
