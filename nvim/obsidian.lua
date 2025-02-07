require("obsidian").setup({
	workspaces = {
		{
			name = "world",
			path = "~/Documents/world",
		},
	},
	completion = {
		nvim_cmp = true,
		min_chars = 1,
	},
	ui = {
		enable = false,
	},
})
