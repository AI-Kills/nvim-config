return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- LSP
        "rust-analyzer",
        "lua-language-server",
        "clangd",
        "json-lsp",
        "typescript-language-server",
        -- Formatters
        "stylua",
        -- "rustfmt", -- Removing rustfmt as it should not be installed via rustup/mason
        "clang-format",
        "prettierd",
        -- Linters
        "shellcheck",
        "luacheck",
      },
    },
  },
}
