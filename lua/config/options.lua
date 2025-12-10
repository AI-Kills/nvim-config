-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

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

-- have functiontions and aliases in nvim cmdline
vim.opt.shell = "/bin/zsh"
vim.opt.shellcmdflag = "-i -c"

-- Miglioramento per sincronizzazione ambiente shell
-- Forza il reload delle variabili d'ambiente e configurazioni shell
vim.opt.shellxquote = ""
vim.opt.shellxescape = ""

-- Funzione per refreshare l'ambiente della shell
_G.refresh_shell_env = function()
    -- Salva la directory corrente
    local cwd = vim.fn.getcwd()

    -- Esegue un comando che ricarica l'ambiente
    local result = vim.fn.system("source ~/.zshrc 2>/dev/null; env")

    -- Parse delle variabili d'ambiente e aggiornamento
    for line in result:gmatch("[^\r\n]+") do
        local key, value = line:match("^([^=]+)=(.*)$")
        if key and value and key ~= "_" then
            vim.fn.setenv(key, value)
        end
    end

    print("Ambiente shell refreshato")
end

-- Comando per refreshare l'ambiente
vim.api.nvim_create_user_command("RefreshEnv", function()
    _G.refresh_shell_env()
end, { desc = "Refresh shell environment variables" })

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

-- Funzione per eseguire comandi Python con l'ambiente corretto
_G.run_python_with_env = function(cmd)
    local python_cmd = "python"

    -- Controlla se siamo in un virtual environment
    local venv = vim.fn.getenv("VIRTUAL_ENV")
    if venv and venv ~= vim.NIL then
        python_cmd = venv .. "/bin/python"
    end

    -- Esegue il comando con il Python corretto
    local full_cmd = python_cmd .. " " .. cmd
    vim.cmd("!" .. full_cmd)
end

-- Comando per eseguire Python con ambiente corretto
vim.api.nvim_create_user_command("PyRun", function(opts)
    _G.run_python_with_env(opts.args)
end, {
    nargs = "*",
    desc = "Run Python command with correct environment",
    complete = "file",
})
