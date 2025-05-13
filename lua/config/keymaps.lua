-- Save all
vim.keymap.set("n", "<leader>sa", ":wa<CR>", {
    noremap = true,
    silent = true,
    desc = "Save all",
})

-- marks
vim.keymap.set("n", "<leader>dm", ":delmarks a-z<CR>", { desc = "Delete all local marks" })

vim.keymap.set("n", "<leader>k", "'", { noremap = true, silent = true, desc = "Go to mark" })

vim.api.nvim_set_keymap(
    "n",
    "<Leader>ff",
    ':lua require"telescope.builtin".find_files({ hidden = true })<CR>',
    { noremap = true, silent = true }
)

-- move among buffers
vim.keymap.set("n", ",", ":bprevious<CR>", { noremap = true, silent = true, desc = "go to previous buffer" })

-- create splits
vim.keymap.set("n", "<leader>v", ":vsplit<CR>", { noremap = true, silent = true, desc = "vertical split" })
vim.keymap.set("n", "<leader>h", ":split<CR>", { noremap = true, silent = true, desc = "horizontal split" })

-- move among splits
vim.keymap.set("n", "<leader>,", "<C-w>l", { noremap = true, silent = true, desc = "close buffer" })
vim.keymap.set("n", "<leader>.", "<C-w>h", { noremap = true, silent = true, desc = "close buffer" })

-- terminal mode
vim.keymap.set("t", "jj", [[<C-\><C-n>]], { noremap = true, silent = true, desc = "Exit terminal insert mode with jj" })

-- folding
vim.keymap.set("n", "H", "zM", {
    noremap = true,
    silent = true,
    desc = "close all folds",
})

vim.keymap.set("n", "h", "za", {
    noremap = true,
    silent = true,
    desc = "open fold",
})

-- Funzione “smart %” ottimizzata:
-- 1) se sei su () [] {} → salto standard
-- 2) altrimenti cerca all’indietro il primo tra ( [ {
local function smart_percent()
    -- 1) carattere sotto il cursore
    local col = vim.fn.col(".")
    local line = vim.fn.getline(".")
    local char = line:sub(col, col)

    -- 2) se è una parentesi, salto standard
    if char:match("[%(%%)%[%]%{%}]") then
        return "%"
    end

    -- 3) altrimenti cerca backwards il primo tra ( [ {
    --    '[([{]' = classe contenente '(', '[' o '{'
    --    'bW' = backwards, no wrap-around
    vim.fn.search("[([{]", "bW")

    -- 4) ritorno vuoto perché la ricerca ha già spostato il cursore
    return ""
end

-- Mapping “expr”: valuta smart_percent() e ne usa il risultato
vim.keymap.set("n", "%", smart_percent, {
    expr = true,
    noremap = true,
    silent = true,
    desc = "Smart %: match standard oppure previous tra '(', '[', '{'",
})
