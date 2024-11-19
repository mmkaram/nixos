require("ibl").setup {
    exclude = {
        filetypes = {
            "dashboard",
            "alpha",
        },
        buftypes = {
            "nofile",
            "terminal",
        },
    },
    indent = {
        char = "│",
        tab_char = "│",
    },
    scope = { show_start = false, show_end = false },
}
