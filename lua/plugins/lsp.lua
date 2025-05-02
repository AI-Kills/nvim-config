local diagnostics = "rust-analyzer" -- Set your default diagnostics tool here

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bacon_ls = {
          enabled = diagnostics == "bacon-ls",
        },
        rust_analyzer = { enabled = false },
      },
      setup = {
      },
    },
  },
}
