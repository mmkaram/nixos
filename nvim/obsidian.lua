require("obsidian").setup({
	workspaces = {
		{
			name = "world",
			path = "~/documents/world",
		},
	},
	completion = {
		nvim_cmp = true,
		min_chars = 1,
	},
})
