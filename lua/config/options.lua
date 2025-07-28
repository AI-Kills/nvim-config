-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- Enable Neovim's built-in status line after disabling lualine
vim.opt.laststatus = 2
vim.opt.ruler = true
vim.opt.showmode = true

-- non fare comparire numerazione delle righe
vim.opt.number = false
vim.opt.relativenumber = false

-- have functiontions and aliases in nvim cmdline
vim.opt.shell = "/bin/zsh"
vim.opt.shellcmdflag = "-i -c"
