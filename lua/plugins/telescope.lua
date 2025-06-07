return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    cmd = "Telescope",
    keys = {
        {
            "<leader>fF",
            "<cmd>Telescope find_files hidden=true no_ignore=true<cr>",
            desc = "Find Files (including hidden and ignored)",
        },
        { "<leader>ff", "<cmd>Telescope find_files hidden=true<cr>", desc = "Find Files (including hidden)" },
        { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
        { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
        { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
    },
    opts = {
        defaults = {
            prompt_prefix = " ",
            selection_caret = " ",
            path_display = { "truncate" },
        },
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            },
        },
    },
    config = function(_, opts)
        require("telescope").setup(opts)
        require("telescope").load_extension("fzf")
    end,
}

