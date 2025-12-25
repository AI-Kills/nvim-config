return {
    "folke/snacks.nvim",
    -- facoltativo ma utile per farlo caricare subito
    priority = 1000,
    lazy = false,

    -- ──────────────────────────────────────────────────────────────
    opts = {
        dashboard = {
            enabled = true, -- senza, la dashboard resta spenta
            --–––––––––––––––––––––––  PRESET  ––––––––––––––––––––––––––
            preset = {
                -- 1. ASCII-art multiriga (stringa → un unico gruppo HL)
                --    Se vuoi righe con HL diversi vedi nota più sotto.
                header = [[
                                                  
                                          
        ___    _________ ____  ____________
       /   |  /  _/ ___// __ \/ ____/_  __/
      / /| |  / / \__ \/ / / / /_    / /   
     / ___ |_/ / ___/ / /_/ / __/   / /    
      /_/  |_/___//____/\____/_/     /_/\_/\~zZ
                                      ( - - )   
                                      \_~_~_/   

        ]],

                -- 2. Tasti rapidi (vengono mostrati dalla sezione “keys”)
                keys = {
                    { icon = "GOD", key = "IS", desc = "", action = ":Telescope find_files" },
                    {
                        icon = "IN ",
                        key = " DETAILS",
                        desc = "",
                        action = ":lua Snacks.dashboard.pick('oldfiles')",
                    },
                },
            },

            --––––––––––––––––––  SECTIONS CHE VUOI MOSTRARE  ––––––––––
            sections = {
                { section = "header" }, -- *obbligatoria* se over-ridei le sezioni
                { section = "keys", gap = 1, padding = 1 },
                { section = "startup" },
            },
        },
    },

    -- ──────────────────────────────────────────────────────────────
    -- Colore fosforescente ↦ override gruppo highlight di default
    init = function()
        local green = "#00FF00" -- verde acido
        vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = green, bold = true })
    end,
}
