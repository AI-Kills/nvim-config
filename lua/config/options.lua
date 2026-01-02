-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
--
-- 1. status line
-- 2. hide numbering of rows

-- Enable Neovim's built-in status line after disabling lualine
vim.opt.laststatus = 0
vim.opt.ruler = true
vim.opt.showmode = false -- mosta la mode (insert etc)
vim.opt.cmdheight = 1 -- nascondi commandline quando inattivo

-- non fare comparire numerazione delle righe
vim.opt.number = false
vim.opt.relativenumber = false

-- Folding settings (Treesitter based)
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldcolumn = "1" -- Mostra la colonna dei fold per chiarezza
vim.opt.fillchars = {
    foldopen = "▾",
    foldclose = "▸",
    fold = " ",
    foldsep = " ",
    diff = "╱",
    eob = " ",
}

-- M) Miglioramento per sincronizzazione ambiente shell

-- M1. Avere aliases e functions dell'env nella commandline di nvim
vim.opt.shell = "/bin/zsh"
vim.opt.shellcmdflag = "-i -c"

-- M2. Forza il reload delle variabili d'ambiente e configurazioni shell
vim.opt.shellxquote = ""
vim.opt.shellxescape = ""

-- Auto-refresh dell'ambiente quando si cambia directory
vim.api.nvim_create_autocmd("DirChanged", {
    pattern = "*",
    callback = function()
        -- Controlla se esiste un venv nella nuova directory
        local venv_path = vim.fn.getcwd() .. "/.venv"
        if vim.fn.isdirectory(venv_path) == 1 then
            -- Attiva automaticamente il venv se presente
            vim.fn.setenv("VIRTUAL_ENV", venv_path)
            vim.fn.setenv("PATH", venv_path .. "/bin:" .. vim.fn.getenv("PATH"))
            print("Virtual environment detected and activated: " .. venv_path)
        end
    end,
    desc = "Auto-activate virtual environment when changing directory",
})
