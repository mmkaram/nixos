local luasnip = require("luasnip")
local s = luasnip.snippet
local t = luasnip.text_node
luasnip.add_snippets("all", {
	s("hi", {
		t("hello, world"),
	}),
})
vim.keymap.set({ "i" }, "<C-K>", function()
	if luasnip.expand_or_jumpable() then
		luasnip.expand_or_jump()
	end
end, { silent = true })
