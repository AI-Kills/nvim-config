-- Nel suo file di configurazione di plugin (es. ~/.config/nvim/lua/plugins/init.lua)
return {
    {
        "gbprod/yanky.nvim",
        dependencies = {
            "kkharji/sqlite.lua", -- Necessario per la persistenza della cronologia
            "nvim-telescope/telescope.nvim", -- Assicurati che Telescope sia installato e configurato
        },
        opts = {
            ring = {
                history_length = 100, -- Lunghezza della cronologia: quante copie memorizzare
                storage = "sqlite", -- Persistenza tra le sessioni di Neovim tramite SQLite
            },
            -- Qui può aggiungere altre opzioni se desidera personalizzare ulteriormente yanky
        },
        keys = {
            -- Mappatura per visualizzare la cronologia degli yank
            -- Abbiamo cambiato '<leader>p' in '<leader>6'
            {
                "<leader>6",
                function()
                    require("telescope").extensions.yank_history.yank_history({})
                end,
                mode = { "n", "x" },
                desc = "Apri Cronologia Copie (Yank)",
            },

            -- Mappature di default per incollare e ciclare la cronologia dopo l'incolla
            -- Queste restano invariate rispetto alla configurazione standard di yanky.nvim
            { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Incolla Testo Dopo Cursore" },
            { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Incolla Testo Prima Cursore" },
            { "<c-n>", "<Plug>(YankyNextEntry)", mode = "n", desc = "Prossimo Elemento Cronologia" },
            { "<c-p>", "<Plug>(YankyPreviousEntry)", mode = "n", desc = "Elemento Precedente Cronologia" },
        },
    },
}
