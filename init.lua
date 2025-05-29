-- Then load the rest of the configuration
require("config.lazy")

vim.g.snacks_animate = false

-- Load our custom cmp_ai setup
require("config.cmp_ai_setup")
