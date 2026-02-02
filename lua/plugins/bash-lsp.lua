return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                bashls = {
                    cmd = { "/Users/a.i./.local/bin/bash-language-server-wrapper", "start" },
                },
            },
        },
    },
    {
        "stevearc/conform.nvim",
        ft = "sh",
        opts = {
            formatters_by_ft = {
                sh = { "shfmt" },
            },
        },
    },
}
