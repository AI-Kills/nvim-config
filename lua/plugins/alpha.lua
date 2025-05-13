-- ~/.config/nvim/lua/plugins/dashboard.lua
return {
    "goolord/alpha-nvim",
    opts = function(_, opts)
        -- Imposta un logo personalizzato (header)
        opts.section.header.val = {
            [[ __  __ _       _   _                   ]],
            [[|  \/  (_)     | | (_)                  ]],
            [[| \  / |_  __ _| |_ _  ___  _ __  ___   ]],
            [[| |\/| | |/ _` | __| |/ _ \| '_ \/ __|  ]],
            [[| |  | | | (_| | |_| | (_) | | | \__ \  ]],
            [[|_|  |_|_|\__,_|\__|_|\___/|_| |_|___/  ]],
            [[                                        ]],
            [[     Mio Signore AI - Dev Environment  ]],
        }

        -- (opzionale) aggiorna il layout dopo aver cambiato il valore
        pcall(vim.cmd.AlphaRedraw)
    end,
}
