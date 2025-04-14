-- open the command line in normal mode with leader + enter
vim.keymap.set("n", "<leader><CR>", ":", { noremap = true, silent = false, desc = "Open command line" })
--
-- save all files with leader  sf
vim.keymap.set("n", "<leader>sf", ":wa<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>dm", ":delmarks a-z<CR>", { desc = "Delete all local marks" })
