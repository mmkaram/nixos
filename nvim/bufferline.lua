-- Ensure that bufferline is loaded
local status, bufferline = pcall(require, "bufferline")
if not status then
    print("Bufferline not found!")
    return
end

-- Setup bufferline with desired options
bufferline.setup({
    options = {
        -- Add any other options you want here
        diagnostics = "nvim_lsp",  -- Example option for diagnostics
        show_buffer_close_icons = false,
        show_close_icon = false,
    }
})

-- Key mappings for navigating buffers
vim.api.nvim_set_keymap('n', '<C-Tab>', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-S-Tab>', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })
