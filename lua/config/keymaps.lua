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
local function smart_percent()
    local col = vim.fn.col(".")
    local line = vim.fn.getline(".")
    local char = line:sub(col, col)

    -- 1) se siamo su una parentesi, salto standard
    if char:match("[%(%)%[%]{}]") then
        vim.cmd("normal! %")
        return
    end

    -- 2) altrimenti cerca backwards '(', '[' o '{'
    -- "[\\(\\[\\{]" diventa in Vim-regex: [\(\[\{] → literal '(', '[', '{'
    vim.fn.search("[\\(\\[\\{]", "bW")
end

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

--- Salta in **alto** alla prima linea non-vuota.
--- Mantiene la colonna, salvo che la riga di destinazione sia più corta.
local function prev_textline()
    local pos = vim.api.nvim_win_get_cursor(0) -- {row, col}
    local row = pos[1]
    local col = pos[2]

    for target = row - 1, 1, -1 do
        local line = vim.fn.getline(target)
        if line:match("%S") then
            vim.api.nvim_win_set_cursor(0, { target, math.min(col, #line) })
            return
        end
    end
    -- Nessuna linea non‐vuota sopra: resta fermo.
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

-- normal mode keys remappings
vim.keymap.set("n", "=", "<Cmd>normal :<CR>", { noremap = true })
vim.keymap.set("n", "=", ":", { noremap = true })

-- visual mode keys remappings

-- j and k + option for "?" and "!"

vim.keymap.set("n", "ª", "?", { noremap = true, silent = true })
vim.keymap.set("v", "ª", "?", { noremap = true, silent = true })
vim.keymap.set("n", "º", "!", { noremap = true, silent = true })
vim.keymap.set("v", "º", "!", { noremap = true, silent = true })
vim.keymap.set("i", "º", "!", { noremap = true, silent = true })
vim.keymap.set("i", "ª", "?", { noremap = true, silent = true })

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

vim.keymap.set("v", "µ", "_", { noremap = true, silent = true })
vim.keymap.set("n", "µ", "_", { noremap = true, silent = true })
vim.keymap.set("i", "µ", "_", { noremap = true, silent = true })

vim.keymap.set("i", "∂", "$", { noremap = true, silent = true })
vim.keymap.set("n", "∂", "$", { noremap = true, silent = true })
vim.keymap.set("v", "∂", "$", { noremap = true, silent = true })

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
