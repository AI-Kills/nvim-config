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
        "rustfmt",
        "clang-format",
        "prettierd",
        
        -- Linters
        "shellcheck",
        "luacheck",
      },
    },
  },
} 