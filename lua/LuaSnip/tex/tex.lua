local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local line_begin = require("luasnip.extras.expand_conditions").line_begin
local in_mathzone = function()
	return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

function get_visual(args, parent)
	if #parent.snippet.env.LS_SELECT_RAW > 0 then
		return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
	else
		return sn(nil, i(1, ""))
	end
end

return {
	s(
		{ trig = "al", snippetType = "autosnippet", condition = line_begin },
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
    \end{<>}
    ]],
			{
				i(1),
				i(2),
				rep(1),
			}
		)
	),

	s(
		{ trig = "eq", regTrig = true, wordTrig = false, snippetType = "autosnippet", condition = line_begin },
		fmta(
			[[
    \begin{equation*}
      <>
    \end{equation*}
    ]],
			{
				i(1),
			}
		)
	),

	s({ trig = "href" }, fmta([[\href{<>}{<>}]], { i(1, "url"), i(2, "display name") })),
	s({ trig = "pkg", snippetType = "autosnippet", condition = line_begin }, fmta([[\usepackage{<>}]], { i(1) })),
	s({ trig = "bb", snippetType = "autosnippet" }, fmta([[\textbf{<>}]], { i(1) })),
	s({ trig = "ss", snippetType = "autosnippet", condition = line_begin }, fmta([[\section*{<>}]], { i(1) })),

	--\hat
	s(
		{ trig = "hat", snippetType = "autosnippet" },
		fmta([[<> <>]], {
			d(
				1, --idex
				function(args, parent, user_args)
					if in_mathzone() then
						return sn(1, fmta([[\hat{<>}]], { i(1) }))
					else
						return sn(1, fmta([[$\hat{<>}$]], { i(1) }))
					end
				end
			),
			i(0),
		})
	),

	--\cdot
	s({ trig = ",%.", snippetType = "autosnippet", regTrig = true, wordTrig = false }, t("\\cdot")),
	--\sqrt
	s({ trig = "sq", snippetType = "autosnippet" }, fmta([[\sqrt{<>} <>]], { i(1), i(0) })),
	--\left \right
	s(
		{ trig = "(.*)%(%(", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta([[<>\left(<>\right)]], {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		})
	),

	s(
		{ trig = "([%w%)%]%}])%*%*", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>^{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = in_mathzone }
	),

	s(
		{ trig = "fig", condition = line_begin, snippetType = "autosnippet" },
		fmta(
			[[
\begin{figure}[H]
  \makebox[\columnwidth]{\includegraphics[scale=.45]{./<>}}
  \caption*{<>}
\end{figure}]],
			{ i(1), i(2) }
		)
	),

	s({ trig = "ra", condition = in_mathzone, snippetType = "autosnippet" }, fmta([[\Rightarrow <>]], { i(0) })),
}
