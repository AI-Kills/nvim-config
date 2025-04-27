-- open the command line in normal mode with leader + enter
vim.keymap.set("n", "<leader><leader>", ":", { noremap = true, silent = false, desc = "Open command line" })

-- marks
vim.keymap.set("n", "<leader>dm", ":delmarks a-z<CR>", { desc = "Delete all local marks" })

vim.keymap.set("n", "<leader>k", "'", { noremap = true, silent = true, desc = "Go to mark" })

vim.api.nvim_set_keymap(
  "n",
  "<Leader>ff",
  ':lua require"telescope.builtin".find_files({ hidden = true })<CR>',
  { noremap = true, silent = true }
)
