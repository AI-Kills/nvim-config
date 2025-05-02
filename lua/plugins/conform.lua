return {
  "stevearc/conform.nvim",
  dependencies = { "mason.nvim" },
  lazy = true,
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ timeout_ms = 3000, lsp_format = "fallback" })
      end,
      mode = { "n", "v" },
      desc = "Format",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      rust = { "rustfmt" },
      -- Add other filetypes as needed
    },
    formatters = {
      -- Override the rustfmt configuration to use cargo-installed version
      rustfmt = {
        -- Use the cargo-installed rustfmt
        command = "rustfmt",
        -- Don't use rustup to run rustfmt
        args = { "--emit=stdout" },
        -- Add stdin capability if needed
        stdin = true,
      },
    },
    -- Format on save
    format_on_save = {
      lsp_format = "fallback",
      timeout_ms = 3000,
    },
  },
} 