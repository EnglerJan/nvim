vim.opt_local.expandtab = true
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2

vim.g.vimtex_imaps_enabled = 0
vim.g.vimtex_env_toggle_map = {
	itemize = "enumerate",
	enumerate = "itemize",
	equation = "align*",
	align = "equation*",
}
vim.keymap.set("n", "ds&", "<Plug>(vimtex-env-delete-math)", { buffer = true })

--vim.g.vimtex_imaps_leader = ","
--vim.cmd([[
--  call vimtex#imaps#add_map({
--        \ 'lhs' : 'v',
--        \ 'rhs' : 'vimtex#imaps#style_math("vec")',
--        \ 'expr' : 1,
--        \ 'leader' : '#',
--        \ 'wrapper' : 'vimtex#imaps#wrap_math'
--        \})
--  call vimtex#imaps#add_map({
--        \ 'lhs' : '1',
--        \ 'rhs' : '\mathds{1}'
--  \})
--  ]])
