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
        ---@type lspconfig.options
        servers = {
            -- tsserver will be automatically installed with mason and loaded with lspconfig
            tsserver = {},
            intelephense = {},
            html = {},
            pylsp = { -- Python LSP con solo errori, no warnings + supporto star import da src
                settings = {
                    pylsp = {
                        plugins = {
                            -- Disabilita tutti i plugin che generano warnings
                            pycodestyle = { enabled = false },
                            pyflakes = { 
                                enabled = true,
                                config = {
                                    -- Ignora solo star import warnings, mantieni errori sintattici
                                    ignore = "F403,F405"
                                }
                            },
                            pylint = { enabled = false },
                            mccabe = { enabled = false },
                            autopep8 = { enabled = false },
                            yapf = { enabled = false },
                            black = { enabled = false },
                            isort = { enabled = false },
                            rope_completion = { enabled = true },
                            jedi_completion = { 
                                enabled = true,
                                fuzzy = true,
                                resolve_eagerly = true
                            },
                            jedi_hover = { enabled = true },
                            jedi_references = { enabled = true },
                            jedi_signature_help = { enabled = true },
                            jedi_symbols = { enabled = true },
                            jedi_definition = { 
                                enabled = true,
                                follow_imports = true,
                                follow_builtin_imports = true
                            },
                        },
                        -- Configurazione globale per jedi - supporto star import
                        jedi = {
                            -- Path per risolvere import relativi
                            extra_paths = { "." },
                            environment = nil, -- Usa l'ambiente Python attivo
                            -- Configurazioni per migliorare risoluzione star import
                            completion = {
                                enabled = true,
                                disable_snippets = false,
                                resolve_eagerly = true,
                                cache_for = { "pandas", "numpy", "requests" }
                            }
                        },
                    },
                },
                -- Setup automatico del Python path per star imports
                on_attach = function(client, bufnr)
                    -- Crea src/__init__.py se non esiste
                    local cwd = vim.fn.getcwd()
                    local src_path = cwd .. "/src"
                    
                    if vim.fn.isdirectory(src_path) == 1 then
                        local init_file = src_path .. "/__init__.py"
                        if vim.fn.filereadable(init_file) == 0 then
                            vim.fn.writefile({}, init_file)
                        end
                    end
                end,
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
            -- ["*"] = function(server, opts) end,
        },
    },
}
