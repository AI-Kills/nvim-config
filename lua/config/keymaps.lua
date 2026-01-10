-- Save all
vim.keymap.set("n", "<leader>l", ":wa<CR>", {
    noremap = true,
    silent = true,
    desc = "Save all",
})

vim.keymap.set("n", ".", ":bd<CR>", {
    noremap = true,
    silent = true,
    desc = "delete buffer",
})

vim.keymap.set("n", "<leader>i", ":lua vim.lsp.buf.hover()<CR>", {
    noremap = true,
    silent = true,
    desc = "see documentation",
})

-- marks
--vim.keymap.set("n", "<leader>dm", ":delmarks a-z<CR>", { desc = "Delete all local marks" })

-- chiamalo con :Ml
vim.api.nvim_create_user_command("Ml", function()
    require("utils.marks").list_files_with_uppercase_marks()
end, {})

-- Funzione per creare mark con lettera maiuscola
local function set_uppercase_mark()
    local char = vim.fn.nr2char(vim.fn.getchar())
    if char:match("[a-zA-Z]") then
        local uppercase_char = char:upper()
        vim.cmd("normal! m" .. uppercase_char)
        vim.cmd("wshada!")
        print("Mark " .. uppercase_char .. " set")
    else
        print("Invalid mark character")
    end
end

-- Funzione per andare al mark con lettera maiuscola
local function goto_uppercase_mark()
    local char = vim.fn.nr2char(vim.fn.getchar())
    if char:match("[a-zA-Z]") then
        local uppercase_char = char:upper()
        vim.cmd("rshada!")
        vim.cmd("normal! '" .. uppercase_char)
    else
        print("Invalid mark character")
    end
end

-- Rimappa 'm' per creare marks maiuscoli
vim.keymap.set("n", "m", set_uppercase_mark, { noremap = true, silent = true, desc = "Set uppercase mark" })

vim.keymap.set("n", "<leader>dam", function()
    vim.cmd("delmarks A-Z")
    vim.cmd("wshada")
end, { desc = "Delete global marks A-Z and save shada" })

-- Rimappa leader+k per andare ai marks maiuscoli
vim.keymap.set("n", "<leader>k", goto_uppercase_mark, { noremap = true, silent = true, desc = "Go to uppercase mark" })
vim.keymap.set("v", "<leader>k", goto_uppercase_mark, { noremap = true, silent = true, desc = "Go to uppercase mark" })

vim.keymap.set("n", "<leader>dm", ":delmarks ")

vim.api.nvim_set_keymap(
    "n",
    "<Leader>ff",
    ':lua require"telescope.builtin".find_files({ hidden = true })<CR>',
    { noremap = true, silent = true }
)

-- move among buffers
vim.keymap.set("n", ",", ":bprevious<CR>", { noremap = true, silent = true, desc = "go to previous buffer" })

-- Salta alla prossima parentesi utile.
-- • Se il cursore è su una parentesi, fa il salto “%” standard.
-- • Altrimenti avanza alla prossima parentesi chiusura “) ] }”.
local function smart_percent_next()
    local col = vim.fn.col(".")
    local line = vim.fn.getline(".")
    local char = line:sub(col, col)

    -- 1) Siamo già su una parentesi → salto abbinato standard
    if char:match("[%(%)%[%]{}]") then
        vim.cmd("normal! %")
        return
    end

    -- 2) Non siamo su una parentesi → cerca in avanti la prossima
    --    parentesi di chiusura “)”, “]” o “}”.
    --    Vim-regex: [\)\]\}]  (backslash per escapare nell’argomento Lua)
    vim.fn.search("[\\(\\)\\[\\]\\{\\}]", "W")
end

-------------------------------------------------------------
--  Salta GIÙ alla prossima riga “utile” (testo o fold chiuso)
-------------------------------------------------------------
local function next_textline()
    local pos = vim.api.nvim_win_get_cursor(0) -- {row, col}
    local row = pos[1]
    local col = pos[2]
    local last = vim.fn.line("$")

    -- Se siamo su un fold chiuso, parti dopo il fold
    if vim.fn.foldclosed(row) == row then
        row = vim.fn.foldclosedend(row)
    end

    local target = row + 1
    while target <= last do
        -----------------------------------------------------------------
        -- 1) Fold chiuso trovato → trattalo come “una riga sola” di testo
        -----------------------------------------------------------------
        local fstart = vim.fn.foldclosed(target)
        if fstart ~= -1 then -- siamo DENTRO (o all’inizio) di un fold chiuso
            vim.api.nvim_win_set_cursor(0, { fstart, math.min(col, #vim.fn.getline(fstart)) })
            return
        end

        --------------------------------------------------
        -- 2) Linea normale con qualcosa di non-whitespace
        --------------------------------------------------
        local line = vim.fn.getline(target)
        if line:match("%S") then
            vim.api.nvim_win_set_cursor(0, { target, math.min(col, #line) })
            return
        end

        target = target + 1
    end
    -- Niente da fare → rimani dov’eri
end

-------------------------------------------------------------
--  Salta SU alla precedente riga “utile” (testo o fold chiuso)
-------------------------------------------------------------
local function prev_textline()
    local pos = vim.api.nvim_win_get_cursor(0) -- {row, col}
    local row = pos[1]
    local col = pos[2]

    -- Se siamo su un fold chiuso, parti prima del fold
    if vim.fn.foldclosed(row) == row then
        row = vim.fn.foldclosed(row) - 1
    end

    local target = row - 1
    while target >= 1 do
        -----------------------------------------------------------------
        -- 1) Fold chiuso trovato → trattalo come “una riga sola” di testo
        -----------------------------------------------------------------
        local fstart = vim.fn.foldclosed(target)
        if fstart ~= -1 then -- siamo DENTRO (o all’inizio) di un fold chiuso
            vim.api.nvim_win_set_cursor(0, { fstart, math.min(col, #vim.fn.getline(fstart)) })
            return
        end

        --------------------------------------------------
        -- 2) Linea normale con qualcosa di non-whitespace
        --------------------------------------------------
        local line = vim.fn.getline(target)
        if line:match("%S") then
            vim.api.nvim_win_set_cursor(0, { target, math.min(col, #line) })
            return
        end

        target = target - 1
    end
    -- Niente da fare → rimani dov’eri
end

local function prev_textline_with_count()
    local count = vim.v.count
    if count > 0 then
        -- Comportamento di default: muovi verso l'alto di 'count' righe
        vim.cmd("normal! " .. count .. "k")
    else
        -- Comportamento custom: salta alla precedente riga con testo (o fold)
        prev_textline()
    end
end

local function next_textline_with_count()
    local count = vim.v.count
    if count > 0 then
        -- Comportamento di default: muovi verso il basso di 'count' righe
        vim.cmd("normal! " .. count .. "j")
    else
        -- Comportamento custom: salta alla prossima riga con testo (o fold)
        next_textline()
    end
end

--  keys remappings
vim.keymap.set("n", "=", ":", { noremap = true })

-- substitute the matches in the selected text
--  just add \%V so that you get  :s/\%Vpippo\%V/carlino_bello/g
--  ../g for global substitution in rows
vim.keymap.set("v", "=", ":s/", { noremap = true })

-- j and k + option for "?" and "!"

vim.keymap.set("n", "º", ":!", { noremap = true })
vim.keymap.set("v", "º", "!", { noremap = true, silent = true })
vim.keymap.set("i", "º", "!", { noremap = true, silent = true })

-- ============================================================================
-- KEYMAPS GLOBALI PER cOMMAND MODE
-- ============================================================================

vim.keymap.set("c", "º", function()
    return "!"
end, { noremap = true, expr = true })

vim.keymap.set("c", "\\\\", "//", { noremap = true })

-- ### moving ###

-- horizontal
vim.keymap.set("n", "h", "b", { noremap = true, silent = true })
vim.keymap.set("n", "l", "e", { noremap = true, silent = true })
vim.keymap.set("v", "l", "e", { noremap = true, silent = true })

vim.keymap.set("n", "e", smart_percent_next, { noremap = true, silent = true })
vim.keymap.set("v", "e", smart_percent_next, { noremap = true, silent = true })

vim.keymap.set("i", "∂", "@", { noremap = true, silent = true })
vim.keymap.set("n", "∂", "@", { noremap = true, silent = true })
vim.keymap.set("v", "∂", "@", { noremap = true, silent = true })

-- vertical
vim.keymap.set(
    "n",
    "k",
    prev_textline_with_count,
    { desc = "k con count → normale; senza count → skip a testo/fold" }
)
vim.keymap.set(
    "n",
    "j",
    next_textline_with_count,
    { desc = "j con count → normale; senza count → skip a testo/fold" }
)
vim.keymap.set(
    "v",
    "k",
    prev_textline_with_count,
    { desc = "k con count → normale; senza count → skip a testo/fold" }
)
vim.keymap.set(
    "v",
    "j",
    next_textline_with_count,
    { desc = "j con count → normale; senza count → skip a testo/fold" }
)

-- folding
-- Close all folds recursively
vim.keymap.set("n", "--", "zM", {
    noremap = true,
    silent = true,
    desc = "close all folds recursively",
})

-- Open current fold (non-recursive)
vim.keymap.set("n", "b", "zo", {
    noremap = true,
    silent = true,
    desc = "open fold (non-recursive)",
})

-- Open all nested folds (recursive)
vim.keymap.set("n", "B", "zO", {
    noremap = true,
    silent = true,
    desc = "open folds recursively",
})

-- Close current fold
vim.keymap.set("n", "c", "zc", {
    noremap = true,
    silent = true,
    desc = "close fold",
})
-- navigating through indentation --- questo serve per python...

-- Funzione locale che effettua il require solo al primo utilizzo
local function jump_prev_less_indent()
    require("utils.indent_nav").jump_prev_less_indent()
end
vim.keymap.set(
    "n", -- normal-mode
    "gk", -- la tua combinazione
    jump_prev_less_indent,
    { desc = "Jump to previous lower indent", silent = true }
)
vim.keymap.set(
    "v", -- normal-mode
    "gk", -- la tua combinazione
    jump_prev_less_indent,
    { desc = "Jump to previous lower indent", silent = true }
)

local function jump_next_greater_indent()
    require("utils.indent_nav").jump_next_greater_indent()
end
vim.keymap.set(
    "n", -- normal-mode
    "gj", -- la tua combinazione
    jump_next_greater_indent,
    { desc = "Jump to next greater indent", silent = true }
)
vim.keymap.set(
    "v", -- normal-mode
    "gj", -- la tua combinazione
    jump_next_greater_indent,
    { desc = "Jump to next greater indent", silent = true }
)

vim.keymap.set(
    "n", -- normal-mode
    "°", -- la tua combinazione
    "]",
    {
        remap = true,
        silent = true,
        desc = "close ]",
    }
)

vim.keymap.set(
    "i", -- normal-mode
    "°", -- la tua combinazione
    "]",
    {
        remap = true,
        silent = true,
        desc = "close ]",
    }
)

vim.keymap.set(
    "v", -- normal-mode
    "°", -- la tua combinazione
    "]",
    {
        remap = true,
        silent = true,
        desc = "close ]",
    }
)

-- mapping strategic movements in a file
vim.keymap.set("n", "<leader>p", "``")

-- deleting rows
vim.keymap.set("n", "dj", ":+1d<CR>")
vim.keymap.set("n", "dk", ":-1d<CR>")

-- sostituzione
vim.keymap.set("n", "S", ":%s/")

vim.keymap.set("v", "$", "g_")

vim.keymap.set("n", "ª", ":?", { desc = "Cerca carattere e vai sul successivo" })

vim.keymap.set("n", "µ", ":! open -a 'cursor' . <CR>", { desc = "apre cursor sulla directory corrente" })

-- ### Moversi all'inzio o alla fine della funzione in cui ci si trova ###
-- Funzione per andare alla fine della funzione corrente usando treesitter
local function go_to_end_of_function()
    local ts_utils = require("nvim-treesitter.ts_utils")
    local parsers = require("nvim-treesitter.parsers")

    -- Verifica se treesitter è disponibile per il buffer corrente
    if not parsers.has_parser() then
        vim.notify("Treesitter parser not available for this filetype", vim.log.levels.WARN)
        return
    end

    -- Ottieni il nodo corrente sotto il cursore
    local node = vim.treesitter.get_node()
    if not node then
        vim.notify("No treesitter node found", vim.log.levels.WARN)
        return
    end

    -- Tipi di nodi che rappresentano funzioni per diversi linguaggi
    local function_node_types = {
        "function_definition", -- Python, Lua
        "function_declaration", -- JavaScript, TypeScript, C
        "function_item", -- Rust
        "method_definition", -- Python (metodi di classe)
        "arrow_function", -- JavaScript/TypeScript
        "function_expression", -- JavaScript
        "method_declaration", -- TypeScript/Java
        "constructor_declaration", -- TypeScript/Java
        "function", -- Generic
    }

    -- Cerca il nodo genitore che rappresenta una funzione
    local function_node = node
    while function_node do
        local node_type = function_node:type()
        for _, func_type in ipairs(function_node_types) do
            if node_type == func_type then
                -- Trovata la funzione! Vai alla fine
                local end_row, end_col = function_node:end_()
                -- Treesitter usa 0-based indexing, vim usa 1-based
                vim.api.nvim_win_set_cursor(0, { end_row + 1, end_col })
                vim.notify("Moved to end of " .. node_type, vim.log.levels.INFO)
                return
            end
        end
        function_node = function_node:parent()
    end

    vim.notify("Not inside a function", vim.log.levels.WARN)
end

-- Mappa gef in visual mode per andare alla fine della funzione
vim.keymap.set("v", "gf", go_to_end_of_function, {
    noremap = true,
    silent = true,
    desc = "Go to end of function (treesitter)",
})
vim.keymap.set("n", "gf", go_to_end_of_function, {
    noremap = true,
    silent = true,
    desc = "Go to end of function (treesitter)",
})

-- Funzione per andare all'inizio della funzione corrente usando treesitter
local function go_to_start_of_function()
    local ts_utils = require("nvim-treesitter.ts_utils")
    local parsers = require("nvim-treesitter.parsers")

    -- Verifica se treesitter è disponibile per il buffer corrente
    if not parsers.has_parser() then
        vim.notify("Treesitter parser not available for this filetype", vim.log.levels.WARN)
        return
    end

    -- Ottieni il nodo corrente sotto il cursore
    local node = vim.treesitter.get_node()
    if not node then
        vim.notify("No treesitter node found", vim.log.levels.WARN)
        return
    end

    -- Tipi di nodi che rappresentano funzioni per diversi linguaggi
    local function_node_types = {
        "function_definition", -- Python, Lua
        "function_declaration", -- JavaScript, TypeScript, C
        "function_item", -- Rust
        "method_definition", -- Python (metodi di classe)
        "arrow_function", -- JavaScript/TypeScript
        "function_expression", -- JavaScript
        "method_declaration", -- TypeScript/Java
        "constructor_declaration", -- TypeScript/Java
        "function", -- Generic
    }

    -- Cerca il nodo genitore che rappresenta una funzione
    local function_node = node
    while function_node do
        local node_type = function_node:type()
        for _, func_type in ipairs(function_node_types) do
            if node_type == func_type then
                -- Trovata la funzione! Vai all'inizio
                local start_row, start_col = function_node:start()
                -- Treesitter usa 0-based indexing, vim usa 1-based
                vim.api.nvim_win_set_cursor(0, { start_row + 1, start_col })
                vim.notify("Moved to start of " .. node_type, vim.log.levels.INFO)
                return
            end
        end
        function_node = function_node:parent()
    end

    vim.notify("Not inside a function", vim.log.levels.WARN)
end

-- Mappa gsf in visual mode e normal mode per andare all'inizio della funzione
vim.keymap.set("v", "gsf", go_to_start_of_function, {
    noremap = true,
    silent = true,
    desc = "Go to start of function (treesitter)",
})
vim.keymap.set("n", "gsf", go_to_start_of_function, {
    noremap = true,
    silent = true,
    desc = "Go to start of function (treesitter)",
})

-- quick open files
vim.keymap.set("n", "<leader>n", ":e $nt/note_veloc*<CR>", { noremap = true })
vim.keymap.set("n", "<leader>h", ":e $nt/cred*<CR>", { noremap = true })

vim.keymap.set("n", "æ", ":?", { noremap = true })

-- commands abbreviations
vim.cmd("cabbrev a qa") -- esempio: lanci :a e esegue :qa

-- Usa la clipboard di sistema
vim.opt.clipboard:append("unnamedplus")

-- :CopyPath [format]  (default = "%:p" = path assoluto)
vim.api.nvim_create_user_command("CopyPath", function(opts)
    local fmt = (opts.args ~= "" and opts.args) or "%:p"
    local path = vim.fn.expand(fmt)
    if path == "" then
        vim.notify("Nessun nome file per il buffer corrente", vim.log.levels.WARN)
        return
    end
    -- copia negli appunti (+ e * per compatibilità)
    vim.fn.setreg("+", path)
    pcall(vim.fn.setreg, "*", path)
    print("Copied to clipboard: " .. path)
end, { nargs = "?" })

-- Abbreviazione command-line: :p -> :CopyPath
vim.cmd("cnoreabbrev p CopyPath")
