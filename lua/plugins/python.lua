return {
  -- 1. Configure Treesitter for Python syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "python" })
      end
    end,
  },

  -- 2. Configure LSP (Pyright and Ruff) for Python
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Pyright configuration for type checking and IntelliSense
        pyright = {
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true,
                typeCheckingMode = "basic", -- Can be "off", "basic", or "strict"
                -- Enable auto-import features
                autoImportCompletions = true,
              },
            },
          },
        },
        -- Ruff LSP for linting, formatting and auto-imports
        ruff_lsp = {
          -- Extend capabilities for better code actions
          capabilities = (function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.codeAction = {
              dynamicRegistration = false,
              codeActionLiteralSupport = {
                codeActionKind = {
                  valueSet = {
                    "quickfix",
                    "refactor",
                    "refactor.extract",
                    "refactor.inline",
                    "refactor.rewrite",
                    "source",
                    "source.organizeImports",
                  },
                },
              },
            }
            return capabilities
          end)(),
          init_options = {
            settings = {
              -- Increase Ruff's capabilities
              logLevel = "error",
              fixAll = true, -- Enable comprehensive auto-fixes
              organizeImports = true, -- Enable import organization
              codeAction = {
                fixAll = {
                  enable = true,
                },
                disableRuleComment = {
                  enable = true,
                },
                showFixAll = true, -- Show "Fix All" code action
                showDisableRule = true, -- Show "Disable Rule" code action
              },
            },
          },
          on_attach = function(client, bufnr)
            -- Add key mappings for common Ruff actions
          end,
        },
      },
      setup = {
        -- Configure interaction between Pyright and Ruff LSP
        ruff_lsp = function()
          require("lazyvim.util").lsp.on_attach(function(client, bufnr)
            -- Let Pyright handle hover details
            if client.name == "ruff_lsp" then
              client.server_capabilities.hoverProvider = false
            end
          end)
        end,
      },
    },
  },

  -- 3. Ensure Python tools are installed with Mason
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "pyright", -- Python LSP server
          "ruff", -- Ruff for linting and formatting (replaces ruff-lsp)
          "debugpy", -- Python debugger
        })
      end
    end,
  },

  -- 4. Configure formatting for Python files
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        python = { "ruff_format" }, -- Use Ruff's built-in formatter
      },
    },
  },

  -- 5. Auto-import setup with nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      -- Enable auto-imports in completion
      opts.mapping = opts.mapping or cmp.mapping.preset.insert({})
      opts.mapping["<CR>"] = cmp.mapping.confirm({
        select = true,
        behavior = cmp.ConfirmBehavior.Replace, -- Auto-import when confirming completion
      })
    end,
  },

  -- 6. Rope for Python refactoring
  {
    "python-rope/rope",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    ft = "python",
  },
}

