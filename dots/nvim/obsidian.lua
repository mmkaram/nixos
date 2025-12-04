local status_ok, obsidian = pcall(require, "obsidian")
if not status_ok then
	return
end

local vault_path = "~/Documents/world"

-- Check if the directory exists before setup to avoid breaking
if vim.fn.isdirectory(vim.fn.expand(vault_path)) == 0 then
	return
end

obsidian.setup({
	workspaces = {
		{
			name = "world",
			path = vault_path,
		},
	},
	completion = {
		nvim_cmp = true,
		min_chars = 1,
	},
	ui = {
		enable = false,
	},
	legacy_commands = false,
})

-- Overrides the 'gf' mapping to work on markdown/wiki links within vaults.
vim.api.nvim_create_autocmd("User", {
	pattern = "ObsidianNoteEnter",
	callback = function(ev)
		vim.keymap.set("n", "gf", "<cmd>Obsidian follow_link<cr>", {
			buffer = ev.buf,
			desc = "Toggle checkbox",
		})
	end,
})
