require("obsidian").setup({
	-- TODO: This poops itself if it can't find the folder
	-- will break on a fresh install if this vault is not right here
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
