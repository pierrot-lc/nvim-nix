if vim.g.theme == "melange" then
	vim.cmd("colorscheme melange")

	if vim.g.transparent_background then
		vim.cmd("hi Normal guibg=NONE")
	end
end

if vim.g.theme == "melange-light" then
	vim.opt.background = "light"
	vim.cmd("colorscheme melange")

	if vim.g.transparent_background then
		vim.cmd("hi Normal guibg=NONE")
	end
end
