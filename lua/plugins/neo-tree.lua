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
            {
                "<leader>e",
                function()
                    -- Controlla se ci sono buffer con file aperti (esclusi neo-tree, buffer vuoti e altri speciali)
                    local buffers = vim.api.nvim_list_bufs()
                    local has_real_buffers = false

                    for _, buf in ipairs(buffers) do
                        if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, "buflisted") then
                            local buftype = vim.api.nvim_buf_get_option(buf, "buftype")
                            local filetype = vim.api.nvim_buf_get_option(buf, "filetype")
                            local bufname = vim.api.nvim_buf_get_name(buf)

                            -- Esclude buffer speciali come neo-tree, terminal, ecc.
                            if buftype == "" and filetype ~= "neo-tree" then
                                -- Controlla se è un buffer vuoto [No Name]
                                local is_empty_buffer = (bufname == "" or bufname:match("%[No Name%]"))
                                    and vim.api.nvim_buf_line_count(buf) <= 1
                                    and vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] == ""

                                -- Se non è un buffer vuoto, allora abbiamo un buffer reale
                                if not is_empty_buffer then
                                    has_real_buffers = true
                                    break
                                end
                            end
                        end
                    end

                    if has_real_buffers then
                        -- Comportamento normale: larghezza 35
                        vim.cmd("Neotree toggle filesystem left")
                    else
                        -- Aspetta che neo-tree si apra e poi forza la larghezza completa
                        vim.defer_fn(function()
                            -- Chiudi tutte le finestre tranne neo-tree per forzare l'espansione
                            local wins = vim.api.nvim_list_wins()
                            local neotree_win = nil

                            -- Trova la finestra neo-tree
                            for _, win in ipairs(wins) do
                                local buf = vim.api.nvim_win_get_buf(win)
                                local ft = vim.api.nvim_buf_get_option(buf, "filetype")
                                if ft == "neo-tree" then
                                    neotree_win = win
                                    break
                                end
                            end

                            if neotree_win then
                                -- Chiudi tutte le altre finestre
                                for _, win in ipairs(wins) do
                                    if win ~= neotree_win then
                                        pcall(vim.api.nvim_win_close, win, false)
                                    end
                                end

                                -- Ora imposta una larghezza molto alta per forzare l'espansione
                                vim.api.nvim_win_set_width(neotree_win, 9999)
                                -- Nessun buffer aperto: apri a tutta larghezza
                                vim.cmd("Neotree show filesystem left")
                            end
                        end, 100)
                    end
                end,
                desc = "Neo-tree file explorer (adaptive width)",
            },
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
                        ["t"] = "filter",
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
