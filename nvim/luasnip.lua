local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local extras = require("luasnip.extras")
local r = extras.rep
local fmt = require("luasnip.extras.fmt").fmt

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
		t(");"),
	}),
	s("rfc", {
		t({
			"export default function ",
		}),
		i(1, "ComponentName"),
		t({
			"() {",
			"  return (",
			"    <div>",
			"      ",
		}),
		i(2, "content"),
		t({
			"",
			"    </div>",
			"  );",
			"}",
		}),
		-- r(1)
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

-- MD
ls.add_snippets("markdown", {
	s(
		"top",
		fmt(
			[[
				---
				title: "{title}"
				date: {date}
				draft: {draft}
				summary: "{summary}"
				---
			]],
			{
				title = i(1, "exampleTitle"),
				date = i(2, "YYYY-MM-DD"),
				draft = i(3, "bool"),
				summary = i(4, "summary"),
			}
		)
	),
})

-- KEYMAPS

vim.keymap.set({ "i", "s" }, "<C-j>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-k>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true })

return ls
