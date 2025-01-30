---@type table<string, vim.lsp.Config>
return {
	cmd = { "clangd" },
	filetypes = { "c", "cpp", "cuda", "objc", "objcpp", "proto" },
	root_markers = {
		".clang-format",
		".clang-tidy",
		".clangd",
		"compile_commands.json",
		"compile_flags.txt",
		"configure.ac",
	},
}
