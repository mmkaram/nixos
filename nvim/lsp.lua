local lspconfig = require("lspconfig")
local util = require("lspconfig.util")
lspconfig.tailwindcss.setup({})
-- Require utils for merge
local function merge(a, b)
	for k, v in pairs(b) do
		a[k] = v
	end
end

local function on_attach(_, bufnr)
	vim.lsp.inlay_hint.enable(true)
	vim.keymap.set("n", "<Space>ta", vim.lsp.buf.signature_help, { buffer = bufnr, noremap = true, silent = true })
end

local settings = {

	-- TODO: Elixir, racket?
	rust_analyzer = {
		cmd = { "rust-analyzer" },
		settings = {
			["rust-analyzer"] = {
				cargo = { loadOutDirsFromCheck = true, features = "full" },
				procMacro = { enable = true },
				expressionAdjustmentHints = { enable = true },
				lifetimeElisionHints = { enable = true },
				inlayHints = {
					enable = true,
					showParameterNames = true,
					parameterHintsPrefix = "<- ",
					otherHintsPrefix = "=> ",
				},
			},
		},
	},
}

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
	"arduino_language_server",
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local nvim_lsp = require("lspconfig")
for server, config in pairs(settings) do
	local setup_obj = {
		on_attach = on_attach,
		capabilities = capabilities,
	}
	merge(setup_obj, config)
	nvim_lsp[server].setup(setup_obj)
end

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
