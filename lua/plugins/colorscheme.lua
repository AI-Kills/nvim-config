return {
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "darkvoid",
        },
    },
    {
        "aliqyan-21/darkvoid.nvim",
        priority = 1000, -- Ensure it loads early
        opts = {
            style = "dark", -- The theme comes in "dark" and "darker" variants
            transparent = false, -- Enable transparent background
            term_colors = true, -- Enable terminal colors
            styles = {
                comments = { italic = true },
                keywords = { italic = true },
                functions = {},
                variables = {},
            },
        },
    },
}
