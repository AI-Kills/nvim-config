local M = {}

function M.setup()
    vim.cmd("hi clear")
    if vim.fn.exists("syntax_on") then
        vim.cmd("syntax reset")
    end
    vim.o.background = "dark"
    vim.g.colors_name = "chatgpt-dark"

    local set = vim.api.nvim_set_hl

    -- Core
    set(0, "Normal", { fg = "#c0c0c0", bg = "#0d0d0d" })
    set(0, "Cursor", { fg = "#0d0d0d", bg = "#bdfe58" })
    set(0, "Visual", { bg = "#3a2a2a" })
    set(0, "LineNr", { fg = "#2a2a2a" })
    set(0, "Comment", { fg = "#4d4d4d", italic = true })

    -- Syntax
    set(0, "Type", { fg = "#F5DEB3" })
    set(0, "Identifier", { fg = "#b0b0b0" })
    set(0, "String", { fg = "#8fae96" })
    set(0, "Function", { fg = "#f0f0f0" })
    set(0, "Keyword", { fg = "#ffffff" })
    set(0, "Constant", { fg = "#CD853F" })
    set(0, "Number", { fg = "#CD853F" })
    set(0, "Boolean", { fg = "#6faaaa" })
    set(0, "Operator", { fg = "#1bfd9c" })
    set(0, "Statement", { fg = "#ffffff" })
    set(0, "PreProc", { fg = "#ffffff" })

    -- Special keywords
    set(0, "KeywordReturn", { fg = "#e06c75", bold = true })
    set(0, "KeywordFunction", { fg = "#e06c75", bold = true })
    set(0, "KeywordClass", { fg = "#e06c75", bold = true })

    -- Popup / UI
    set(0, "Pmenu", { fg = "#c0c0c0", bg = "#0d0d0d" })
    set(0, "PmenuSel", { bg = "#1bfd9c" })
    set(0, "Search", { bg = "#1bfd9c", fg = "#0d0d0d" })
    set(0, "VertSplit", { fg = "#666666" })
    set(0, "Title", { fg = "#bdfe58" })

    -- Diff
    set(0, "DiffAdd", { fg = "#baffc9" })
    set(0, "DiffChange", { fg = "#ffffba" })
    set(0, "DiffDelete", { fg = "#ffb3ba" })

    -- Diagnostics
    set(0, "DiagnosticError", { fg = "#dea6a0" })
    set(0, "DiagnosticWarn", { fg = "#d6efd8" })
    set(0, "DiagnosticHint", { fg = "#bedc74" })
    set(0, "DiagnosticInfo", { fg = "#7fa1c3" })
end

return M
