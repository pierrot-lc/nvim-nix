local starter = require("mini.starter")
local telescope_section = starter.sections.telescope()

-- Evaluate the function until we get the table.
while type(telescope_section) == "function" do
	telescope_section = telescope_section()
end

-- Remove the "Browser" section. I don't use this telescope extension.
for i = #telescope_section, 1, -1 do
	if telescope_section[i].name == "Browser" then
		table.remove(telescope_section, i)
	end
end

-- require("mini.starter").setup({
-- 	autoopen = true,
-- 	items = {
-- 		telescope_section,
-- 		starter.sections.recent_files(5, true, false),
-- 		starter.sections.builtin_actions(),
-- 	},
-- 	header = logo,
-- 	footer = "",
-- 	content_hooks = {
-- 		starter.gen_hook.aligning("center", "center"),
-- 	},
-- })
