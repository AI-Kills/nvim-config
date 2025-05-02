return {
  -- Add C language support
  -- 1. Configure Treesitter for C syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "c" })
      end
    end,
  },

  -- 2. Configure LSP (clangd) for C language
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          cmd = { "clangd", "--background-index", "--clang-tidy" },
          filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern(
              "compile_commands.json",
              "compile_flags.txt",
              ".git",
              "Makefile"
            )(fname) or vim.fn.getcwd()
          end,
        },
      },
    },
  },

  -- 3. Ensure clangd and C-related tools are installed
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "clangd",        -- C/C++ language server
          "clang-format",  -- C/C++ formatter
          "codelldb",      -- Debugger
        })
      end
    end,
  },

  -- 5. Configure formatting for C files
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        c = { "clang-format" },
      },
    },
  },
} 