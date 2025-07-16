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

local line_begin = require("luasnip.extras.expand_conditions").line_begin
local in_mathzone = function()
	return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

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
	\begin{equation*}
		<>
	\end{equation*}
	]],
			{ i(1) }
		)
	),

	s(
		{ trig = "al" },
		fmta(
			[[
	\begin{align*}
		<> &= <> \\
		<> &= <>
	\end{align*}]],
			{ i(1), i(2), i(3), i(4) }
		)
	),

	s(
		{ trig = "([^%a])ff", regTrig = true, wordTrig = false, snippetType = "autosnippet", condition = in_mathzone },
		fmta([[<>\frac{<>}{<>}]], {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
			i(2),
		})
	),

	s(
		{ trig = "en", regTrig = true, wordTrig = false, snippetType = "autosnippet", condition = line_begin },
		fmta(
			[[
    \begin{<>}
      <>
    \end{<>}]],
			{
				i(1),
				i(2),
				rep(1),
			}
		)
	),

	s({ trig = "href" }, fmta([[\href{<>}{<>}]], { i(1, "url"), i(2, "display name") })),
	s({ trig = "pkg" }, fmta([[\usepackage{<>}]], { i(1) })),
}
