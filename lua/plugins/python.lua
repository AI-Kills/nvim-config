return {
  -- Configure ruff for formatting only, not linting
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters = {
        ruff_format = {
          command = "ruff",
          args = { "format", "--stdin-filename", "$FILENAME", "-" },
          stdin = true,
        },
        ruff_organize_imports = {
          command = "ruff", 
          args = { "check", "--select", "I", "--fix", "--stdin-filename", "$FILENAME", "-" },
          stdin = true,
        },
      },
    },
  },
} 