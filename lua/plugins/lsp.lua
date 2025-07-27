return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "jose-elias-alvarez/typescript.nvim",
        init = function()
            require("lazyvim.util").lsp.on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
                vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
            end)
        end,
    },
    ---@class PluginLspOpts
    opts = {
        -- Configure diagnostics to show only errors
        diagnostics = {
            virtual_text = {
                severity = vim.diagnostic.severity.ERROR,
            },
            signs = {
                severity = vim.diagnostic.severity.ERROR,
            },
            underline = {
                severity = vim.diagnostic.severity.ERROR,
            },
            update_in_insert = false,
        },
        ---@type lspconfig.options
        servers = {
            -- tsserver will be automatically installed with mason and loaded with lspconfig
            tsserver = {},
            intelephense = {},
            html = {},
            pyright = {
                settings = {
                    python = {
                        analysis = {
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                            diagnosticMode = "workspace"
                        }
                    }
                }
            },
        },
        -- you can do any additional lsp server setup here
        -- return true if you don't want this server to be setup with lspconfig
        ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
        setup = {
            -- example to setup with typescript.nvim
            tsserver = function(_, opts)
                require("typescript").setup({ server = opts })
                return true
            end,
            -- Specify * to use this function as a fallback for any server
            ["*"] = function(server, opts)
                -- Filter diagnostics to show only errors
                local orig_handler = vim.lsp.handlers["textDocument/publishDiagnostics"]
                vim.lsp.handlers["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
                    -- Filter to only show errors
                    result.diagnostics = vim.tbl_filter(function(diagnostic)
                        return diagnostic.severity == vim.diagnostic.severity.ERROR
                    end, result.diagnostics)
                    return orig_handler(_, result, ctx, config)
                end
                return false
            end,
        },
    },
}
