-- Add this to your plugin configuration
require("which-key").setup({
	-- Basic configuration
	plugins = {
		marks = true,
		registers = true,
		spelling = {
			enabled = true,
			suggestions = 20,
		},
		presets = {
			operators = true,
			motions = true,
			text_objects = true,
			windows = true,
			nav = true,
			z = true,
			g = true,
		},
	},
	-- Use a slightly faster delay than default
	delay = 150,
	-- Use your existing descriptions
	icons = {
		breadcrumb = "»",
		separator = "➜",
		group = "+",
	},
})

-- Add group descriptions for better organization
require("which-key").add({
	-- Define your leader key groups
	{ "<leader>t", group = "Telescope" },
	{ "<leader>s", group = "Splits/Buffer" },
	{ "<leader>n", group = "New Split" },
	{ "<leader>l", group = "Git" },
	{ "<leader>f", group = "File/Zen" },
	{ "<leader>m", group = "Markdown" },
	{ "<leader>o", group = "File Explorer" },
	{ "<leader>u", group = "Undotree" },
	{ "<leader>tx", group = "Trouble" },
})
