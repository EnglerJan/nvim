-- Define the focus function in Lua
local function tex_focus_vim()
	-- Sleep for 200ms to allow Zathura to take focus
	vim.fn.system("sleep 0.08")

	-- Refocus the original Vim window
	vim.fn.system("xdotool windowfocus " .. vim.g.vim_window_id)

	-- Redraw the Vim screen
	vim.cmd("redraw!")
end

-- Set up the autocmd group for VimTeX's view event
vim.api.nvim_create_augroup("vimtex_event_focus", { clear = true })

vim.api.nvim_create_autocmd("User", {
	group = "vimtex_event_focus",
	pattern = "VimtexEventView",
	callback = tex_focus_vim,
})
