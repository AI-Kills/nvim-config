-- Then load the rest of the configuration
require("config.lazy")

-- Disable netrw completely

vim.g.snacks_animate = false

--[[vim.fn.timer_start(6000, function()
    vim.cmd("rshada!")
    print("debug: marks letti da shada, ora sono disponibili")
end, { ["repeat"] = -1 }) ]]
