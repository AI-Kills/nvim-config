-- Then load the rest of the configuration
require("config.lazy")

vim.g.snacks_animate = false
vim.g.netrw_banner = 0

--[[vim.fn.timer_start(6000, function()
    vim.cmd("rshada!")
    print("debug: marks letti da shada, ora sono disponibili")
end, { ["repeat"] = -1 }) ]]
