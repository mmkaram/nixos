require("avante").setup({
	provider = "gemini",
	gemini = {
		model = "gemini-2.0-flash",
		timeout = 30000,
		temperature = 0,
		max_tokens = 4096,
	},
	behaviour = {
		auto_suggestions = true,
		auto_set_highlight_group = true,
		auto_set_keymaps = true,
		auto_apply_diff_after_generation = false,
		support_paste_from_clipboard = false,
	},
})
