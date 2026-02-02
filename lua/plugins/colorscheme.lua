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

    -- 2. Override di LazyVim
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "github_dark_default",
            defaults = {
                autocmds = false,
            },
            news = {
                lazyvim = false,
                neovim = false,
            },
        },
    },

    -- 3. Disabilita noice.nvim (usa cmdline classica in basso)
    { "folke/noice.nvim", enabled = false },
    { "rcarriga/nvim-notify", enabled = false },
}
