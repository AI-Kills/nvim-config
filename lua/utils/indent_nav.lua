local M = {}

--- Vai alla prima riga sopra la corrente con indentazione strettamente minore,
--- saltando le linee vuote.
function M.jump_prev_less_indent()
    local cur_line = vim.fn.line(".")
    local cur_indent = vim.fn.indent(cur_line)
    if cur_line == 1 then
        return
    end

    for l = cur_line - 1, 1, -1 do
        local line_text = vim.fn.getline(l)
        local indent_l = vim.fn.indent(l)

        -- salta linee vuote o whitespace-only
        if line_text:match("%S") and indent_l < cur_indent then
            -- primo char visibile (byte-index, 0-based)
            local col = line_text:find("%S") - 1
            -- clamp nel dubbio (tabs o multibyte)
            local max_col = #line_text
            if col < 0 then
                col = 0
            end
            if col > max_col then
                col = max_col
            end

            vim.api.nvim_win_set_cursor(0, { l, col })
            return
        end
    end
end
--- Vai alla prima riga sotto la corrente con indentazione strettamente maggiore,
--- ignorando le linee vuote / whitespace-only.
function M.jump_next_greater_indent()
    local cur_line = vim.fn.line(".")
    local last_line = vim.fn.line("$")
    local cur_indent = vim.fn.indent(cur_line)
    if cur_line == last_line then
        return
    end

    for l = cur_line + 1, last_line do
        local line_text = vim.fn.getline(l)
        local indent_l = vim.fn.indent(l)

        -- salta linee vuote
        if line_text:match("%S") and indent_l > cur_indent then
            -- primo char non-bianco (0-based)
            local col = line_text:find("%S") - 1
            local max_col = #line_text
            if col < 0 then
                col = 0
            end
            if col > max_col then
                col = max_col
            end

            vim.api.nvim_win_set_cursor(0, { l, col })
            return
        end
    end
end
return M
