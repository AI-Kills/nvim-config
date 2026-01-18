return {
    -- 1. Treesitter for Terraform
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            if type(opts.ensure_installed) == "table" then
                vim.list_extend(opts.ensure_installed, { "terraform", "hcl" })
            end
        end,
    },

    -- 2. LSP (terraform-ls)
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                terraformls = {},
            },
        },
    },

    -- 3. Mason - install terraform-ls
    {
        "mason-org/mason.nvim",
        opts = function(_, opts)
            if type(opts.ensure_installed) == "table" then
                vim.list_extend(opts.ensure_installed, { "terraform-ls" })
            end
        end,
    },

    -- 4. Formatting via conform (terraform fmt)
    {
        "stevearc/conform.nvim",
        ft = { "terraform", "tf", "hcl" },
        opts = {
            formatters_by_ft = {
                terraform = { "terraform_fmt" },
                tf = { "terraform_fmt" },
                hcl = { "terraform_fmt" },
            },
            format_on_save = { timeout_ms = 3000, lsp_format = "fallback" },
        },
    },
}
