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
                },
            })

            vim.cmd("colorscheme github_dark_default")
        end,
    },

    -- 2. Override di LazyVim per disabilitare highlight allo yank
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "github_dark_default",
            defaults = {
                autocmds = false,
            },
        },
    },
}
