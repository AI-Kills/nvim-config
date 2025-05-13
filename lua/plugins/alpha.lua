return {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")
        
        -- Imposta un logo personalizzato (header)
        dashboard.section.header.val = {
            [[ __  __ _       _   _                   ]],
            [[|  \/  (_)     | | (_)                  ]],
            [[| \  / |_  __ _| |_ _  ___  _ __  ___   ]],
            [[| |\/| | |/ _` | __| |/ _ \| '_ \/ __|  ]],
            [[| |  | | | (_| | |_| | (_) | | | \__ \  ]],
            [[|_|  |_|_|\__,_|\__|_|\___/|_| |_|___/  ]],
            [[                                        ]],
            [[     Mio Signore AI - Dev Environment  ]],
        }
        
        -- Configura i pulsanti
        dashboard.section.buttons.val = {
            dashboard.button("f", "  Find File", ":Telescope find_files <CR>"),
            dashboard.button("n", "  New File", ":ene <BAR> startinsert <CR>"),
            dashboard.button("p", "  Projects", ":Telescope projects <CR>"),
            dashboard.button("g", "  Find Text", ":Telescope live_grep <CR>"),
            dashboard.button("r", "  Recent Files", ":Telescope oldfiles <CR>"),
            dashboard.button("c", "  Config", ":e $MYVIMRC <CR>"),
            dashboard.button("s", "  Restore Session", ":lua require('persistence').load() <CR>"),
            dashboard.button("x", "  Lazy Extras", ":LazyExtras <CR>"),
            dashboard.button("q", "  Quit", ":qa<CR>"),
        }
        
        -- Imposta il layout
        alpha.setup(dashboard.opts)
        
        -- Chiudi automaticamente Neovim se Alpha è l'unico buffer rimasto
        vim.api.nvim_create_autocmd("User", {
            pattern = "AlphaReady",
            desc = "Alpha autocmds",
            callback = function()
                vim.opt.laststatus = 0
                vim.api.nvim_create_autocmd("BufUnload", {
                    buffer = 0,
                    callback = function()
                        vim.opt.laststatus = 3
                    end,
                })
            end,
        })
    end,
}
