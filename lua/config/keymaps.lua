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

-- create splits
vim.keymap.set("n", "<leader>v", ":vsplit<CR>", { noremap = true, silent = true, desc = "vertical split" })
vim.keymap.set("n", "<leader>h", ":split<CR>", { noremap = true, silent = true, desc = "horizontal split" })

-- move among splits
vim.keymap.set("n", "<leader>,", "<C-w>l", { noremap = true, silent = true, desc = "close buffer" })
vim.keymap.set("n", "<leader>.", "<C-w>h", { noremap = true, silent = true, desc = "close buffer" })

-- folding
vim.keymap.set("n", "-h", "zM", {
    noremap = true,
    silent = true,
    desc = "close all folds",
})

vim.keymap.set("n", "h", "za", {
    noremap = true,
    silent = true,
    desc = "open fold",
})

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

-- Mapping “callback” in Neovim (senza expr)
vim.keymap.set("n", "%", smart_percent, {
    noremap = true,
    silent = true,
    desc = "Smart %: standard match o previous '(', '[' o '{'",
})

-- normal mode keys remappings
vim.keymap.set("n", "=", "<Cmd>normal :<CR>", { noremap = true })
vim.keymap.set("n", "=", ":", { noremap = true })

vim.keymap.set("n", "|", "$", { noremap = true, silent = true })
vim.keymap.set("n", "D", "_", { noremap = true, silent = true })
vim.keymap.set("n", "l", smart_percent, { noremap = true, silent = true })

-- visual mode keys remappings
vim.keymap.set("v", "|", "$", { noremap = true, silent = true })
vim.keymap.set("v", "D", "_", { noremap = true, silent = true })
vim.keymap.set("v", "l", smart_percent, { noremap = true, silent = true })

-- insert mode keys remappings
vim.keymap.set("i", "D", "_", { noremap = true, silent = true })
