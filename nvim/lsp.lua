-- Require utils for merge
-- Merges ...dictionaries? objects? tables?
function merge(a, b)
    for k, v in pairs(b) do
        a[k] = v
    end
end

local function on_attach(client, bufnr)
    vim.lsp.inlay_hint.enable(true)
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
                inlayHints = {
                    enable = true,
                    showParameterNames = true,
                    parameterHintsPrefix = "<- ",
                    otherHintsPrefix = "=> ",
                },
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
