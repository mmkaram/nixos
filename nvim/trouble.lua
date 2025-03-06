local trouble = require("trouble")

vim.keymap.set("n", "<space>tx", function()
	trouble.open("diagnostics")
end, { desc = "Open LSP issues in Trouble" })
