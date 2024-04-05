local dashboard = require("alpha.themes.dashboard")

local logo = [[
   ⸝○⸜                      
○---○---○                   
○---○---○           Go deep!
○---○---○                   
   ⸌○⸍                      
]]

dashboard.section.header.val = vim.split(logo, "\n")
dashboard.section.buttons.val = {
	dashboard.button("n", " " .. " New file", "<cmd>ene <bar> startinsert<cr>"),
	dashboard.button("r", "󱋡 " .. " Recent files", "<cmd>Telescope oldfiles<cr>"),
	dashboard.button("f", "󰈢 " .. " Find file", "<cmd>Telescope find_files<cr>"),
	dashboard.button("g", "󰺮 " .. " Find text", "<cmd>Telescope live_grep<cr>"),
	dashboard.button("q", " " .. " Quit", "<cmd>qa<cr>"),
}
for _, button in ipairs(dashboard.section.buttons.val) do
	button.opts.hl = "AlphaButtons"
	button.opts.hl_shortcut = "AlphaShortcut"
end
dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "AlphaHeader"
dashboard.section.buttons.opts.hl = "AlphaButtons"
dashboard.opts.layout[1].val = 4

require("alpha").setup(dashboard.opts)
