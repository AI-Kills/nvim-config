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
                bind_to_cwd = true,
                follow_current_file = { enabled = false },
                use_libuv_file_watcher = true,
                filtered_items = {
                    visible = false,
                    hide_dotfiles = true,
                    hide_gitignored = true,
                    hide_by_name = { "coverage", ".DS_Store" },
                    hide_by_pattern = { "*.lock", "*.min.js", "__*.py" },
                },
                window = {
                    position = "left",
                    width = 999,
                    mappings = {
                        ["s"] = false,
                        ["l"] = "open",
                        ["h"] = "close_node",
                        ["p"] = "toggle_preview",
                        ["."] = "toggle_hidden",
                    },
                },
            },
            default_component_configs = {
                indent = {
                    with_expanders = true, -- Assicura che gli expander siano attivati
                    expander_collapsed = "", -- Icona freccia destra (più compatibile)
                    expander_expanded = "", -- Icona freccia giù (più compatibile)
                    expander_highlight = "NeoTreeExpander",
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
        config = function(_, opts)
            -- Forziamo il colore delle frecce ad essere molto visibile (Bianco/Grigio chiaro)
            vim.api.nvim_set_hl(0, "NeoTreeExpander", { fg = "#ffffff", bold = true })

            require("neo-tree").setup(opts)
        end,
    },
}
