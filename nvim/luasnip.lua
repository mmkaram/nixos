local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- ALL SNIPS
ls.add_snippets("all", {
	s("td", {
		t("TODO:"),
	}),
})

-- JS / TS / JSX / TSX

local jsset = {
	s("cl", {
		t("console.log("),
		i(1),
		t(")"),
	}),
}

ls.add_snippets("typescriptreact", jsset)
ls.add_snippets("typescript", jsset)

-- LUA

ls.add_snippets("lua", {
	s("print", {
		t('print("'),
		i(1),
		t('")'),
	}),
})

-- KEYMAPS

vim.keymap.set({ "i" }, "<C-g>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<tab>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<S-tab>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true })
