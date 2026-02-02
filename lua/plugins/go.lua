return {
    -- Add Go language support
    -- 1. Configure Treesitter for Go syntax highlighting
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            if type(opts.ensure_installed) == "table" then
                vim.list_extend(opts.ensure_installed, { "go", "gomod", "gowork", "gosum" })
            end
        end,
    },

    -- 2. Configure LSP (gopls) for Go language
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                gopls = {
                    settings = {
                        gopls = {
                            gofumpt = true,
                            codelenses = {
                                gc_details = false,
                                generate = true,
                                regenerate_cgo = true,
                                run_govulncheck = true,
                                test = true,
                                tidy = true,
                                upgrade_dependency = true,
                            },
                            analyses = {
                                unusedparams = true,
                            },
                            staticcheck = true,
                        },
                    },
                },
            },
        },
    },

    -- 3. Ensure gopls and Go-related tools are installed
    {
        "mason-org/mason.nvim",
        opts = function(_, opts)
            if type(opts.ensure_installed) == "table" then
                vim.list_extend(opts.ensure_installed, {
                    "gopls", -- Go language server
                    "gofumpt", -- Go formatter (stricter gofmt)
                    "goimports", -- Go imports organizer
                    "golangci-lint", -- Go linter
                })
            end
        end,
    },

}
