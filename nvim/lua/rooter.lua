-- Change working directory based on the root of the current project.
-- Thanks to https://nanotipsforvim.prose.sh/automatically-set-the-cwd-without-rooter-plugin.

local rooter = function()
	-- First, find the root dir based on the first git repository.
	local root = vim.fs.root(0, { ".git" })

	-- Otherwise, use the parent directory of the buffer.
	if not root then
		local filename = vim.api.nvim_buf_get_name(0)
		root = vim.fs.root(0, filename)
	end

	if not root then
		error("Could not find a root directory!")
	end

	vim.uv.chdir(root)
end

vim.api.nvim_create_user_command(
	"Rooter",
	rooter,
	{ desc = "Change working directory based on the root of the given buffer" }
)

return {
	rooter = rooter,
}
