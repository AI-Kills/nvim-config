-- custom commandline
vim.keymap.set("n", ";", ":", {
    noremap = true,
    silent = true,
    desc = "Command line",
})
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
vim.keymap.set("n", ".", ":bnext<CR>", { noremap = true, silent = true, desc = "go to next buffer" })
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
