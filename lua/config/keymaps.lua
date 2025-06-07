-- Save all
vim.keymap.set("n", "<leader>sa", ":wa<CR>", {
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

    desc = "delete see documentation",
})

-- marks
vim.keymap.set("n", "<leader>dm", ":delmarks a-z<CR>", { desc = "Delete all local marks" })

vim.keymap.set("n", "<leader>k", "'", { noremap = true, silent = true, desc = "Go to mark" })
vim.keymap.set("v", "<leader>k", "'", { noremap = true, silent = true, desc = "Go to mark" })

vim.api.nvim_set_keymap(
    "n",
    "<Leader>ff",
    ':lua require"telescope.builtin".find_files({ hidden = true })<CR>',
    { noremap = true, silent = true }
)

-- move among buffers
vim.keymap.set("n", ",", ":bprevious<CR>", { noremap = true, silent = true, desc = "go to previous buffer" })

-- Smart %: jump se sei su (), [] o {} altrimenti
-- vai all’indietro al primo fra (, [ o {

-- Mapping CLI (esempio)
vim.api.nvim_set_keymap("n", "<leader>%", ":lua smart_percent()<CR>", { noremap = true, silent = true })
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
    vim.fn.search("[\\)\\]\\}]", "W")
end

local function smart_percent()
    -- Ottieni posizione del cursore (riga, colonna zero-index)
    local row, col0 = unpack(vim.api.nvim_win_get_cursor(0))
    -- Leggi tutte le righe del buffer
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

    -- Scansione inversa: riga per riga, colonna per colonna
    for r = row, 1, -1 do
        local line = lines[r]
        -- Determina la colonna di partenza per la scansione inversa
        local start_c
        if r == row then
            -- Se siamo sulla riga corrente, inizia prima del carattere attuale
            if col0 >= 1 then
                start_c = col0 -- esclude il carattere sotto il cursore
            else
                -- Se siamo in col0=0 (prima colonna), salta a fine riga
                start_c = #line
            end
        else
            -- Per righe precedenti, inizia dalla fine
            start_c = #line
        end
        for c = start_c, 1, -1 do
            local ch = line:sub(c, c)
            -- Verifica se è una parentesi aperta: (, [ o {
            if ch:match("[%(%%[%{]") then
                -- Imposta il cursore sulla parentesi aperta trovata (colonna zero-index)
                vim.api.nvim_win_set_cursor(0, { r, c - 1 })
                return
            end
        end
    end

    print("Nessuna parentesi aperta trovata.")
end

-- Mappatura CLI: premi <leader>% per smart_percent
vim.api.nvim_set_keymap("n", "<leader>%", ":lua smart_percent()<CR>", { noremap = true, silent = true })

-- Mappatura CLI: premi <leader>% per smart_percent
vim.api.nvim_set_keymap("n", "<leader>%", ":lua smart_percent()<CR>", { noremap = true, silent = true })

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
vim.keymap.set("n", "=", "<Cmd>normal :<CR>", { noremap = true })
vim.keymap.set("n", "=", ":", { noremap = true })

-- j and k + option for "?" and "!"

vim.keymap.set("n", "ª", "?", { noremap = true, silent = true })
vim.keymap.set("v", "ª", "?", { noremap = true, silent = true })
vim.keymap.set("i", "ª", "?", { noremap = true, silent = true })

vim.keymap.set("n", "º", "!", { noremap = true, silent = true })
vim.keymap.set("v", "º", "!", { noremap = true, silent = true })
vim.keymap.set("i", "º", "!", { noremap = true, silent = true })

-- ### moving ###

-- horizontal
vim.keymap.set("n", "h", "b", { noremap = true, silent = true })
vim.keymap.set("n", "l", "e", { noremap = true, silent = true })
vim.keymap.set("v", "h", "b", { noremap = true, silent = true })
vim.keymap.set("v", "l", "e", { noremap = true, silent = true })

vim.keymap.set("n", "b", smart_percent, { noremap = true, silent = true })
vim.keymap.set("n", "e", smart_percent_next, { noremap = true, silent = true })
vim.keymap.set("v", "b", smart_percent, { noremap = true, silent = true })
vim.keymap.set("v", "e", smart_percent_next, { noremap = true, silent = true })

-- extremal horizontal

vim.keymap.set("v", "ƒ", "_", { noremap = true, silent = true })
vim.keymap.set("n", "ƒ", "_", { noremap = true, silent = true })
vim.keymap.set("i", "ƒ", "_", { noremap = true, silent = true })

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
vim.keymap.set("n", "-∆", "zM", {
    noremap = true,
    silent = true,
    desc = "close all folds",
})

vim.keymap.set("n", "∆", "za", {
    noremap = true,
    silent = true,
    desc = "open fold",
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

-- closing parenterses
