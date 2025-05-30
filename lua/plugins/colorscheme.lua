return {
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "darkvoid",
        },
    },

    {
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
                transparent = true,
                glow = true,
                show_end_of_buffer = true,

                colors = {
                    --------------------------------------------------------------------
                    -- Core Darkness ---------------------------------------------------
                    --------------------------------------------------------------------
                    fg = "#c0c0c0",
                    bg = "#0d0d0d",
                    cursor = "#bdfe58",
                    line_nr = "#2a2a2a",
                    visual = "#252525",

                    --------------------------------------------------------------------
                    -- Syntax ----------------------------------------------------------
                    --------------------------------------------------------------------
                    comment = "#4d4d4d",
                    type = "#5f666c",
                    type_builtin = "#888888",
                    bracket = "#9a9a9a",
                    identifier = "#b0b0b0",
                    string = "#8fae96", -- Verde-grigio per le stringhe
                    func = "#f0f0f0",
                    kw = "#ffffff", -- tutte le keyword bianche
                    constant = "#c07f3f",
                    number = "#c07f3f",
                    bool = "#6faaaa",
                    operator = "#1bfd9c", -- unico tocco turchese

                    -- Rosso usato SOLO per return, function e class
                    keyword_return = "#e06c75",
                    keyword_function = "#e06c75",
                    keyword_class = "#e06c75",

                    search_highlight = "#1bfd9c",

                    --------------------------------------------------------------------
                    -- Diff & Popup ----------------------------------------------------
                    --------------------------------------------------------------------
                    added = "#baffc9",
                    changed = "#ffffba",
                    removed = "#ffb3ba",

                    pmenu_bg = "#0d0d0d",
                    pmenu_sel_bg = "#1bfd9c",
                    pmenu_fg = "#c0c0c0",
                    eob = "#2a2a2a",
                    border = "#666666",
                    title = "#bdfe58",
                    bufferline_selection = "#1bfd9c",

                    --------------------------------------------------------------------
                    -- Diagnostics -----------------------------------------------------
                    --------------------------------------------------------------------
                    error = "#dea6a0",
                    warning = "#d6efd8",
                    hint = "#bedc74",
                    info = "#7fa1c3",

                    --------------------------------------------------------------------
                    -- Plugin Support --------------------------------------------------
                    --------------------------------------------------------------------
                    plugins = {
                        gitsigns = true,
                        nvim_cmp = true,
                        treesitter = true,
                        nvimtree = true,
                        telescope = true,
                        lualine = true,
                        bufferline = true,
                        oil = true,
                        whichkey = true,
                        nvim_notify = true,
                    },
                },
            },
        },
    },
}
