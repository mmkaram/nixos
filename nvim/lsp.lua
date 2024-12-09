-- Require utils for merge
-- Merges ...dictionaries? objects? tables?
function merge(a, b)
    for k, v in pairs(b) do
        a[k] = v
    end
end

local function toggle_inlay_hints()
    local bufnr = vim.api.nvim_get_current_buf() -- Get the current buffer number
    local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
    vim.lsp.inlay_hint.enable(not is_enabled, { bufnr = bufnr })
    print("Inlay hints " .. (is_enabled and "disabled" or "enabled"))
end

local function on_attach(client, bufnr)
    -- Enable inlay hints if the server supports it
    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end

    -- Define a key mapping to toggle inlay hints
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ih', '<cmd>lua toggle_inlay_hints()<CR>', { noremap = true, silent = true })
end


local settings = {

	-- TODO: Elixir, racket?, js?

	-- haskell
	hls = {
		cmd = { "haskell-language-server-wrapper", "--lsp" },
		filetypes = { 'haskell', 'lhaskell', 'cabal' },

	},

	-- cmp
	clangd = {
		cmd = { "clangd" },
		filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
	},

	-- python
	pyright = {
		cmd = { "pyright-langserver", "--stdio" },
		filetypes = {"python"},
		settings = {
			["pyright"] = {
				analysis = {
					autoSearchPaths = true,
					diagnosticMode = "openFilesOnly",
					useLibraryCodeForTypes = true
				}
			}

		}
	},

    rust_analyzer = {
	    cmd = {"rust-analyzer"},
        settings = {
            ["rust-analyzer"] = {
                cargo = {loadOutDirsFromCheck = true, features = 'full'},
                procMacro = {enable = true},
                expressionAdjustmentHints = { enable = true },
                lifetimeElisionHints = { enable = true },
            }
        }
    },
    lua_ls = {
        cmd = {"lua-language-server"},
        settings = {
            Lua = {
                workspace = {
                    library = {
                        -- TODO fix
                        ['/usr/share/nvim/runtime/lua'] = true,
                        ['/usr/share/nvim/runtime/lua/lsp'] = true,
                    }
                },
                diagnostics = {
                    enable = true,
                    globals = {
                        "vim",
                    },
                    disable = "lowercase-global"
                },
                completion = {
                    enable = true,
                    workspaceWord = false
                }
            }
        }
    },
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local nvim_lsp = require('lspconfig')
for server, config in pairs(settings) do
    local setup_obj = {
        on_attach = on_attach, -- Use the updated on_attach
        capabilities = capabilities
    }
    merge(setup_obj, config)
    nvim_lsp[server].setup(setup_obj)
end

-- Set up nvim-cmp
local cmp = require('cmp')
	cmp.setup({
	mapping = cmp.mapping.preset.insert({
	    ['<Enter>'] = cmp.mapping.confirm({ select = true }),
	}),
})
