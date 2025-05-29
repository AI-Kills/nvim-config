return {
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "darkvoid",
        },
    },

    {
        "aliqyan-21/darkvoid.nvim",
        priority = 1000,
        opts = {
            transparent = false,
            glow = true,
            show_end_of_buffer = true,

            colors = {
                ----------------------------------------------------------------------
                --  Core Darkness ----------------------------------------------------
                ----------------------------------------------------------------------
                fg = "#c0c0c0", -- Testo principale
                bg = "#1c1c1c", -- Sfondo
                cursor = "#bdfe58", -- Verde tossico
                line_nr = "#353535", -- Numeri di linea
                visual = "#252525", -- Selezione

                ----------------------------------------------------------------------
                --  Syntax (grigi ottimizzati) --------------------------------------
                ----------------------------------------------------------------------
                comment = "#4d4d4d", -- Commenti: scuro ma leggibile
                string = "#b3b3b3", -- Stringhe: medio–chiaro
                identifier = "#e0e0e0", -- Variabili: quasi bianco
                func = "#f0f0f0", -- Nomi di funzione: quasi puro
                kw = "#ffffff", -- Keywords: bianco pieno
                type = "#8c8c8c", -- Tipi: scuro–medio
                type_builtin = "#aaaaaa", -- Tipi built-in: grigio chiaro
                constant = "#9fcfcf", -- Costanti: ciano tenue
                bool = "#6faaaa", -- Booleani: blu-grigio
                operator = "#1bfd9c", -- Operatori: verde vivo
                search_highlight = "#1bfd9c", -- Evidenziatore di ricerca

                bracket = "#d0d0d0", -- Parentesi e simboli
                preprocessor = "#4b8902", -- Direttive preprocessor

                ----------------------------------------------------------------------
                --  Diff & Popup -----------------------------------------------------
                ----------------------------------------------------------------------
                added = "#baffc9",
                changed = "#ffffba",
                removed = "#ffb3ba",

                pmenu_bg = "#1c1c1c",
                pmenu_sel_bg = "#1bfd9c",
                pmenu_fg = "#c0c0c0",

                eob = "#3c3c3c",

                border = "#666666",
                title = "#bdfe58",
                bufferline_selection = "#1bfd9c",

                ----------------------------------------------------------------------
                --  Diagnostics ------------------------------------------------------
                ----------------------------------------------------------------------
                error = "#dea6a0",
                warning = "#d6efd8",
                hint = "#bedc74",
                info = "#7fa1c3",
            },
        },
    },
}
