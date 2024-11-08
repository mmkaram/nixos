-- Require utils for merge
-- Merges ...dictionaries? objects? tables?
function merge(a, b)
    for k, v in pairs(b) do
        a[k] = v
    end
end

-- Import and set up keybindings
-- local on_attach = require('keybindings')
-- on_attach.setup()

local settings = {
    rust_analyzer = {
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
        on_attach = on_attach,
        capabilities = capabilities
    }
    merge(setup_obj, config)
    nvim_lsp[server].setup(setup_obj)
    nvim_lsp[server].setup(config)
end

-- Set up nvim-cmp
local cmp = require('cmp')
	cmp.setup({
	mapping = cmp.mapping.preset.insert({
	    ['<Enter>'] = cmp.mapping.confirm({ select = true }),
	}),
	-- other cmp settings...
})
