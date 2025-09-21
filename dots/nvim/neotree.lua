require("neo-tree").setup({
	window = { mappings = { ["l"] = "toggle_node" } },
	sources = { "filesystem", "document_symbols" },
})
