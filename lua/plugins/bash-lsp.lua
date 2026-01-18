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
            format_on_save = { timeout_ms = 3000, lsp_format = "fallback" },
        },
    },
}
