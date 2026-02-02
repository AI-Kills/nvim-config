return {
    "folke/trouble.nvim",
    keys = {
        -- Override: <leader>x toggle diagnostics (invece di <leader>xx)
        {
            "<leader>x",
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            desc = "Diagnostics (Trouble)",
        },
        -- Mantieni anche ]d [d per navigare velocemente senza aprire trouble
        {
            "]d",
            function()
                vim.diagnostic.goto_next()
            end,
            desc = "Next diagnostic",
        },
        {
            "[d",
            function()
                vim.diagnostic.goto_prev()
            end,
            desc = "Prev diagnostic",
        },
    },
    opts = {
        focus = true, -- focus automatico sulla finestra trouble
    },
}
