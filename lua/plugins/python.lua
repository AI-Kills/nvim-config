return {
    {
        "stevearc/conform.nvim",
        ft = "python",
        opts = {
            formatters_by_ft = {
                python = { "ruff_format", "ruff_organize_imports" },
            },
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
            format_on_save = { timeout_ms = 3000, lsp_format = "fallback" },
        },
        keys = {
            { "<leader>cf", function() require("conform").format() end, ft = "python", desc = "Format" },
        },
    },
}
