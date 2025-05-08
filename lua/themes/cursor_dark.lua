-- ~/.config/nvim/lua/themes/cursor-dark.lua
return {
  name = "cursor-dark",
  background = "dark",
  highlights = {
    Normal = { fg = "#d8dee9", bg = "NONE" },
    NormalNC = { fg = "#D4D4D4", bg = "NONE" },
    Comment = { fg = "#6d6d6d", italic = true },
    Constant = { fg = "#CE9178" },
    String = { fg = "#e394dc" },
    Number = { fg = "#ebc88d" },
    Keyword = { fg = "#83d6c5" },
    Identifier = { fg = "#d8dee9" },
    Function = { fg = "#B5CEA8" },
    Type = { fg = "#DCDCAA" },
    Structure = { fg = "#C586C0" },
    LineNr = { fg = "#444444" },
    CursorLine = { bg = "#2A2A2A" },
    Visual = { bg = "#264F78" },
    Pmenu = { fg = "#D4D4D4", bg = "#252526" },
    PmenuSel = { fg = "#FFFFFF", bg = "#094771" },
    VertSplit = { fg = "#3C3C3C" },
    StatusLine = { fg = "#FFFFFF", bg = "#333333" },
    StatusLineNC = { fg = "#AAAAAA", bg = "#2D2D2D" },
    Directory = { fg = "#569CD6" },
    -- Types
    ["@type"] = { fg = "#94c1fa" }, -- Tipi custom importati
    ["@type.builtin"] = { fg = "#569CD6" }, -- Tipi JS/TS (Promise, string, number...)

    -- Variables
    ["@variable"] = { fg = "#aa9bf5" }, -- Variabili e const
    ["@variable.builtin"] = { fg = "#569CD6" }, -- this, arguments, etc.

    -- Functions
    ["@function"] = { fg = "#efb080", bold = false }, -- Dichiarazioni di funzione
    ["@function.call"] = { fg = "#efb080", bold = false }, -- Chiamate di funzione
    ["@function.builtin"] = { fg = "#569CD6" }, -- Funzioni JS standard (es. parseInt)

    -- Punctuation ({} <> ())
    ["@punctuation.bracket"] = { fg = "#ffd700" }, -- parentesi () [] {}
    ["@punctuation.delimiter"] = { fg = "#ffd700" }, -- virgole, punto e virgola
    ["@punctuation.special"] = { fg = "#ffd700" },
    ["@lsp.type.type"] = { link = "@type" },
    ["@lsp.type.class"] = { link = "@type" },
    ["@lsp.type.function"] = { link = "@function" },
    ["@lsp.type.method"] = { link = "@function" },
    ["@lsp.type.parameter"] = { link = "@variable" },
    ["@lsp.type.namespace"] = { fg = "#c792ea" },
    ["@lsp.mod.readonly"] = { italic = true },

    -- HTML
    ["@tag"] = { fg = "#569CD6" }, -- Tag HTML (<div>, <p>, etc.)
    ["@tag.attribute"] = { fg = "#9CDCFE" }, -- Attributi HTML (class, id, etc.)
    ["@tag.delimiter"] = { fg = "#808080" }, -- Delimitatori tag (<, >, /)

    -- String e Template literals
    ["@string.special"] = { fg = "#CE9178" }, -- Stringhe speciali
    ["@string.escape"] = { fg = "#D7BA7D" }, -- Caratteri escape

    -- Keywords e Operatori
    ["@keyword.operator"] = { fg = "#569CD6" }, -- Operatori speciali (typeof, instanceof)
    ["@keyword.function"] = { fg = "#C586C0" }, -- Keywords relativi alle funzioni
    ["@keyword.return"] = { fg = "#C586C0" }, -- Return statement

    -- Properties e Members
    ["@property"] = { fg = "#FFFFFF" }, -- Proprietà di oggetti
    ["@field"] = { fg = "#FFFFFF" }, -- Campi di classi/oggetti
    ["@variable.member"] = { fg = "#FFFFFF" }, -- Membri di oggetti/classi

    -- TypeScript specifico
    ["@lsp.type.property"] = { fg = "#FFFFFF" }, -- Proprietà TS rilevate da LSP
    ["@lsp.type.member"] = { fg = "#FFFFFF" }, -- Membri oggetto TS rilevati da LSP
    ["@lsp.typemod.property.readonly"] = { fg = "#FFFFFF", italic = true }, -- Proprietà readonly
    ["@lsp.typemod.variable.defaultLibrary"] = { fg = "#569CD6" }, -- Variabili libreria standard

    -- Object literals e accessors
    ["@property.definition"] = { fg = "#FFFFFF" }, -- Definizione di proprietà in object literals
    ["@operator.object"] = { fg = "#ffd700" }, -- Operatore punto per accesso a proprietà
    ["@variable.object.property"] = { fg = "#FFFFFF" }, -- Proprietà riferite tramite this

    -- Modules
    ["@module"] = { fg = "#c792ea" } -- Import/export statements
  }
}
