local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("lua", {
    s("log", {
        t({"console.log("}),
        i(1, "arg"),
        t({")",""}),
    }),
    s("for", { t("for "), i(1, "i"), t(" in "), i(2, "iterable"), t(" do"), t({"", "\t"}), i(3), t({"", "end"}) }),
})

ls.add_snippets("typescriptreact", {
    s("rfcghyt", {
        t({"import React from 'react';", ""}),
        t("const "), i(1, "ComponentName"), t(" = (props) => {"),
        t({"", "    return ("}),
        t({"", "        <div>"}),
        i(2, "Your content here"),
        t({"", "        </div>"}),
        t({"", "    );"}),
        t({"", "};"}),
        t({"", "", "export default ", i(1), ";"}),
    }),
})
