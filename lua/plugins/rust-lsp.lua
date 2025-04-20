return {
  -- Override LSP configuration specifically for Rust to address E475 error
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = false,
        severity_sort = true,
      },
      servers = {
        rust_analyzer = {
          -- Add specific settings if needed
          settings = {
            ['rust-analyzer'] = {
              checkOnSave = {
                command = "clippy",
              },
              assist = {
                importGranularity = "module",
                importPrefix = "by_self",
              },
              cargo = {
                loadOutDirsFromCheck = true,
                allFeatures = true,
              },
              procMacro = {
                enable = true,
                ignored = {
                  ["async-trait"] = { "async_trait" },
                  ["napi-derive"] = { "napi" },
                  ["async-recursion"] = { "async_recursion" },
                },
              },
            },
          },
          -- Add this handler to prevent E475 errors 
          handlers = {
            ["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
              -- Filter out any diagnostics that might cause E475
              local filtered_diagnostics = {}
              for _, diagnostic in ipairs(result.diagnostics) do
                -- Keep diagnostics that won't cause E475
                -- You might need to adjust this filter based on your specific error
                if diagnostic.message and not diagnostic.message:match("E475") then
                  table.insert(filtered_diagnostics, diagnostic)
                end
              end
              result.diagnostics = filtered_diagnostics
              
              -- Call the default handler with filtered diagnostics
              vim.lsp.handlers["textDocument/publishDiagnostics"](_, result, ctx, config)
            end,
          },
        },
      },
    },
  },
} 