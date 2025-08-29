-- Keybinding per incollare l'n-esimo elemento della yank history con leader + numero

return {
    {
        "gbprod/yanky.nvim",
        dependencies = {
            "kkharji/sqlite.lua", -- Necessario per la persistenza della cronologia
            "nvim-telescope/telescope.nvim", -- Assicurati che Telescope sia installato e configurato
        },
        opts = {
            ring = {
                history_length = 50, -- Lunghezza della cronologia: quante copie memorizzare
                storage = "sqlite", -- Persistenza tra le sessioni di Neovim tramite SQLite
            },
        },
        keys = {
            -- Mappatura per visualizzare la cronologia degli yank
            {
                "<leader>y",
                function()
                    require("telescope").extensions.yank_history.yank_history({})
                end,
                mode = { "n", "x" },
                desc = "Apri Cronologia Copie (Yank)",
            },

            -- Keybinding per incollare l'n-esimo elemento della yank history (sempre prima del cursore)
            {
                "{p",
                function()
                    vim.cmd('normal! "2P')
                end,
                mode = { "n", "x", "c" },
                desc = "Incolla 1° Elemento Yank Prima",
            },
            {
                "]p",
                function()
                    vim.cmd('normal! "3P')
                end,
                mode = { "n", "x", "c" },
                desc = "Incolla 2° Elemento Yank Prima",
            },
            { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Incolla Testo Prima Cursore" },
            { "<c-n>", "<Plug>(YankyNextEntry)", mode = "n", desc = "Prossimo Elemento Cronologia" },
            { "<leader>@", "<Plug>(YankyPreviousEntry)", mode = "n", desc = "Elemento Precedente Cronologia" },
        },
    },
}
