return {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    lazy = true,
    cmd = "ConformInfo",
    keys = {
        {
            "<leader>cf",
            function()
                require("conform").format({ timeout_ms = 3000, lsp_format = "fallback" })
            end,
            mode = { "n", "v" },
            desc = "Format",
        },
    },
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            rust = { "rustfmt" },
            python = { "ruff_format" },
            c = { "clang-format" },
            sh = { "shfmt" },
            php = { "php_cs_fixer" },
            -- Add other filetypes as needed
        },
        formatters = {
            -- Override the rustfmt configuration to use cargo-installed version
            rustfmt = {
                command = "rustfmt",
                args = { "--emit=stdout" },
                stdin = true,
            },
            -- Configure stylua with increased timeout
            stylua = {
                command = "stylua",
                args = { "--search-parent-directories", "--stdin-filepath", "$FILENAME", "-" },
                stdin = true,
                timeout = 5000, -- Increase timeout for larger files
            },
            -- Configure ruff_format with increased timeout
            ruff_format = {
                command = "ruff",
                args = { "format", "--stdin-filename", "$FILENAME", "-" },
                stdin = true,
                timeout = 5000, -- Increase timeout for larger files
            },
        },
        -- Format on save with longer timeout and better error handling
        format_on_save = function(bufnr)
            -- Don't autoformat files in gitcommit mode
            if vim.bo[bufnr].filetype == "gitcommit" then
                return
            end

            -- Don't format if file has problems
            local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
            if vim.tbl_isempty(lines) or (#lines == 1 and lines[1] == "") then
                return
            end

            return {
                lsp_format = "fallback",
                timeout_ms = 5000,
            }
        end,
    },
}
