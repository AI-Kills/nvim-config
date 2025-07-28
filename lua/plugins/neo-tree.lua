return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        cmd = "Neotree",
        keys = {
            { "<leader>e", "<cmd>Neotree toggle filesystem left<CR>", desc = "Neo-tree file explorer" },
        },
        opts = {
            sources = { "filesystem", "buffers", "git_status" },
            filesystem = {
                bind_to_cwd = true, -- Ora neo-tree segue i cambiamenti di directory
                follow_current_file = { enabled = true },
                use_libuv_file_watcher = true,
                filtered_items = {
                    visible = false, -- di default non mostrarli
                    hide_dotfiles = true, -- .env, .git, .eslintrc…
                    hide_gitignored = true, -- node_modules/, dist/, ecc.
                    hide_by_name = { "coverage", ".DS_Store" },
                    hide_by_pattern = { "*.lock", "*.min.js", "__*.py" },
                },
                window = {
                    position = "left",
                    width = 35,
                    mappings = {
                        ["s"] = false,
                        ["l"] = "open",
                        ["h"] = "close_node",
                        ["<space>"] = "toggle_preview",
                        ["."] = "toggle_hidden",
                    },
                },
            },
            default_component_configs = {
                indent = {
                    with_expanders = true,
                    expander_collapsed = "",
                    expander_expanded = "",
                },
                git_status = {
                    symbols = { unstaged = "󰄱", staged = "✅" },
                },
            },
            window = {
                mappings = {
                    ["Y"] = {
                        function(state)
                            local node = state.tree:get_node()
                            vim.fn.setreg("+", node:get_id(), "c")
                        end,
                        desc = "Copy path",
                    },
                    ["O"] = {
                        function(state)
                            require("lazy.util").open(state.tree:get_node().path, { system = true })
                        end,
                        desc = "Open with OS",
                    },
                },
            },
        },
    },
}
