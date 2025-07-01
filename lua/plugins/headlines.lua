return {
    "lukas-reineke/headlines.nvim",
    ft = { "markdown" },
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = {
        markdown = {
            headline_highlights = {
                "Headline1",
                "Headline2",
                "Headline3",
                "Headline4",
                "Headline5",
                "Headline6",
            },
            codeblock_highlight = "DarkvoidCodeBlock",
            fat_headlines = false, -- <-- niente barre
        },
    },
    config = function(_, opts)
        require("headlines").setup(opts)

        local hl = vim.api.nvim_set_hl
        local brand = "#1bfd9c"
        local dark = "#0d0d0d"

        -- Titoli pieni
        hl(0, "Headline1", { fg = dark, bg = brand, bold = true })
        hl(0, "Headline2", { fg = dark, bg = brand, bold = true })
        hl(0, "Headline3", { fg = dark, bg = "#CD853F", bold = true })
        hl(0, "Headline4", { fg = dark, bg = "#F5DEB3", bold = true })
        hl(0, "Headline5", { fg = dark, bg = "#8fae96", bold = true })
        hl(0, "Headline6", { fg = dark, bg = "#c0c0c0", bold = true })

        -- Code-block scuro
        hl(0, "DarkvoidCodeBlock", { bg = "#2a2a2a", fg = "#f0f0f0" })

        -- Inline
        hl(0, "@text.strong.markdown_inline", { fg = brand, bold = true })
        hl(0, "@text.emphasis.markdown_inline", { fg = "#6faaaa", italic = true })
        hl(0, "@text.literal.markdown_inline", { fg = "#8fae96" })
    end,
}
