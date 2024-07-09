local MiniJump2d = require("mini.jump2d")

MiniJump2d.setup({
	spotter = MiniJump2d.start(MiniJump2d.builtin_opts.word_start),
	allowed_windows = { not_current = false },
})
