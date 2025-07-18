vim.g.vimtex_env_toggle_map = {
	itemize = "enumerate",
	enumerate = "itemize",
	equation = "align*",
	align = "equation*",
}
vim.g.vimtex_quickfix_open_on_warning = 0
vim.keymap.set("n", "ds&", "<Plug>(vimtex-env-delete-math)", { buffer = true })

if vim.g.vim_window_id == nil then
	vim.g.vim_window_id = vim.fn.system("xdotool getactivewindow")
end
