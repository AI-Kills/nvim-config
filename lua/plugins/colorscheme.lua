return {
    -- 1. Plugin GitHub Theme
    {
        "projekt0n/github-nvim-theme",
        lazy = false,
        priority = 1000,
        config = function()
            require("github-theme").setup({
                options = {
                    transparent = false,
                    styles = {
                        functions = "italic",
                        comments = "italic",
                        keywords = "bold",
                    },
                    darken = {
                        sidebars = {
                            enable = true, -- CORREZIONE: 'enable' invece di 'enabled'
                            list = { "qf", "terminal", "lazy" },
                        },
                    },
                },
            })

            vim.cmd("colorscheme github_dark_default")
        end,
    },

    -- 2. Override di LazyVim
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "github_dark_default",
            defaults = {
                autocmds = false, -- Disabilita gli autocmd di default (incluso highlight yank)
            },
        },
    },
}
