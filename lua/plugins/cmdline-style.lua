-- lua/plugins/cmdline-border.lua
return {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        config = function()
            ---------------------------------------------------------
            -- funzione dinamica su cambio colori-scheme
            ---------------------------------------------------------
            local function set_cmd_border()
                local accent = vim.api.nvim_get_hl(0, { name = "Identifier" }).fg or 0x1bfd9c
                local color = string.format("#%06x", accent)
                vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = color, bg = "NONE" })
            end

            set_cmd_border()
            vim.api.nvim_create_autocmd("ColorScheme", { callback = set_cmd_border })

            ---------------------------------------------------------
            -- optional: uniforma tutti i float
            ---------------------------------------------------------
            vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#1bfd9c", bg = "NONE" })
        end,
    },
}
