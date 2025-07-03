local ls = require("luasnip")
local s, t, i, f = ls.snippet, ls.text_node, ls.insert_node, ls.function_node

--vim.keymap.set({ "i" }, "<Tab>", function()
--	ls.expand()
--end, { silent = true })

return {
	-- al   -->   \begin{align*} … \end{align*}
	s("al", {
		t({ "\\begin{align*}", "\t" }),
		i(0),
		t({ "", "\\end{align*}" }),
	}),

	s("ala", {
		t({ "\\begin{equation*}", "\t" }),
		i(0),
		t({ "", "\\end{equation*}" }),
	}),
}
