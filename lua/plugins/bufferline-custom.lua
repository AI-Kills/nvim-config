return {
    "akinsho/bufferline.nvim",
    event = "BufAdd",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
        options = {
            -- Modalità: "buffers" (default) o "tabs"
            mode = "buffers",

            -- Stile separatori: "slant", "padded_slant", "slope", "thick", "thin"
            separator_style = "thin", -- prova anche "slant" per stile moderno

            -- Numeri sui tab: "none", "ordinal", "buffer_id", "both"
            numbers = "none",

            -- Dimensioni
            tab_size = 20,
            max_name_length = 15,

            -- Icone e simboli
            buffer_close_icon = "󰅖",
            modified_icon = "●",
            close_icon = "",
            left_trunc_marker = "",
            right_trunc_marker = "",

            -- Comportamento
            show_buffer_icons = false,
            show_buffer_close_icons = false,
            show_close_icon = false,
            color_icons = none,

            -- Diagnostici LSP
            diagnostics = "nvim_lsp",
            diagnostics_indicator = function(count, level, diagnostics_dict, context)
                local icon = level:match("error") and " " or " "
                return " " .. icon .. count
            end,

            -- Ordinamento
            sort_by = "insert_after_current", -- o "extension", "directory"

            -- Offset per sidebar (es. neo-tree)
            offsets = {
                {
                    filetype = "neo-tree",
                    text = "File Explorer",
                    text_align = "center",
                    separator = true,
                },
            },

            -- Custom filter per nascondere certi buffer
            custom_filter = function(buf_number, buf_numbers)
                -- Nascondi buffer temporanei
                if vim.bo[buf_number].filetype ~= "oil" then
                    return true
                end
                return false
            end,
        },

        -- Highlight groups personalizzati
        highlights = {
            fill = {
                bg = "#0d0d0d", -- Colore sfondo
            },
            background = {
                fg = "#666666",
                bg = "#1a1a1a",
            },
            buffer_selected = {
                fg = "#1bfd9c", -- Usa il colore dal tuo theme
                bg = "#0d0d0d",
                bold = true,
                italic = false,
            },
            separator = {
                fg = "#333333",
                bg = "#1a1a1a",
            },
            separator_selected = {
                fg = "#1bfd9c",
                bg = "#0d0d0d",
            },
        },
    },
}
