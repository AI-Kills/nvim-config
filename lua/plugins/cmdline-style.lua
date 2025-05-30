-- lua/plugins/cmdline-border.lua
return {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        config = function()
            ---------------------------------------------------------
            ---
            -- funzione dinamica su cambio colori-scheme
            ---------------------------------------------------------

            ---------------------------------------------------------
            -- optional: uniforma tutti i float
            ---------------------------------------------------------
            vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#1bfd9c" })
        end,
    },
}
