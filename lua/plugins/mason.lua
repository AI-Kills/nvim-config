return {
    {
        "mason-org/mason.nvim",
        opts = {
            ensure_installed = {
                -- LSP
                "rust-analyzer",
                "lua-language-server",
                "clangd",
                "json-lsp",
                "typescript-language-server",
                "intelephense",
                "css-lsp",
                -- Formatters
                "stylua",
                -- "rustfmt", -- Removing rustfmt as it should not be installed via rustup/mason
                "clang-format",
                "prettierd",
            },
        },
    },
}
