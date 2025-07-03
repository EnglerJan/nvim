local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

return {
	--s("al", {
	--	t({ "\\begin{align*}", "\t" }),
	--	i(1),
	--	t({ "", "\\end{align*}" }),
	--}),
	s(
		{ trig = "eq" },
		fmta(
			[[
	\begin{equation}
		<>
	\end{equation}
	]],
			{ i(1) }
		)
	),

	s(
		{ trig = "f" },
		fmta(
			[[
	\frac{<>}{<>}
	]],
			{ i(1), i(2) }
		)
	),

	s(
		{ trig = "env" },
		fmta(
			[[
	\begin{<>}
		<>
	\end{<>}
	<>]],
			{ i(1), i(2), rep(1), i(0) }
		)
	),

	s({ trig = "href" }, fmta([[\href{<>}{<>}]], { i(1, "url"), i(2, "display name") })),
	--s({ trig = "pkg" }, fmta([[\usepackage{<>}]], { i(1) })),
}
