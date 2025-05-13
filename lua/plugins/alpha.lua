return {
    "goolord/alpha-nvim",
    event = "VimEnter",
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

        -- Assicurati che il layout venga aggiornato
        if vim.fn.has("nvim-0.9.0") == 1 then
            vim.api.nvim_create_autocmd("User", {
                pattern = "AlphaReady",
                callback = function()
                    pcall(vim.cmd.AlphaRedraw)
                end,
            })
        else
            pcall(vim.cmd.AlphaRedraw)
        end
    end,
}
