require("autoclose").setup({
	keys = {
		["'"] = { escape = false, close = false, pair = "''" },
	},
	options = {
		disabled_filetypes = { "text", "markdown" },
	},
})
