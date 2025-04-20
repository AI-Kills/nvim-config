return {
  -- Add Rust language support
  -- 1. Configure Treesitter for Rust syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "rust" })
      end
    end,
  },

  -- 2. Configure LSP (rust-analyzer) for Rust language
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        rust_analyzer = {
          settings = {
            ['rust-analyzer'] = {
              checkOnSave = {
                command = "clippy",
              },
              cargo = {
                allFeatures = true,
              },
              procMacro = {
                enable = true,
              },
            },
          },
        },
      },
    },
  },

  -- 3. Ensure rust-analyzer and Rust-related tools are installed
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "rust-analyzer",  -- Rust language server
          "rustfmt",        -- Rust formatter
        })
      end
    end,
  },

  -- 4. Add extra Rust-specific tools/plugins
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    opts = function()
      return {
        tools = {
          autoSetHints = true,
          inlay_hints = {
            show_parameter_hints = true,
          },
        },
        server = {
          -- Standalone file support
          -- Setting this to true might cause issues, depending on your setup
          standalone = false,
        },
      }
    end,
    config = function(_, opts)
      require("rust-tools").setup(opts)
    end,
  },

  -- 5. Configure formatting for Rust files
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        rust = { "rustfmt" },
      },
    },
  },
} 