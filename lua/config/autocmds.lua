-- Add any autocmds here

-- Auto-open neo-tree when trying to edit a directory
vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("DirectoryToNeotree", { clear = true }),
    callback = function()
        local path = vim.fn.expand("%:p")
        if vim.fn.isdirectory(path) == 1 then
            -- Close the current buffer
            vim.cmd("bdelete")
            -- Open neo-tree at the directory
            vim.cmd("Neotree filesystem reveal_force_cwd dir=" .. vim.fn.fnameescape(path))
        end
    end,
})

-- Colori truecolor
vim.opt.termguicolors = true

-- Gruppo highlight trasparente (bg NONE), riapplicato su cambio colorscheme
local function set_term_transparent_hl()
    vim.api.nvim_set_hl(0, "TermTrans", { bg = "NONE" })
end
set_term_transparent_hl()
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = set_term_transparent_hl,
})

-- Autocmd per i buffer terminali
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "term://*",
    callback = function(ev)
        -- Opzioni locali pulite
        vim.opt_local.number = false
        vim.opt_localrelativenumber = false
        vim.opt_local.signcolumn = "no"
        vim.opt_local.foldcolumn = "0"

        -- Trasparenza SOLO in questa finestra (senza toccare il resto di Neovim)
        vim.api.nvim_win_set_option(
            0,
            "winhl",
            "Normal:TermTrans,NormalNC:TermTrans,SignColumn:TermTrans,EndOfBuffer:TermTrans"
        )

        -- Keymaps locali al buffer terminale
        local opts = { buffer = ev.buf, silent = true }
        -- Esc: esci da terminal-mode -> normal-mode
        vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)
    end,
})

-- Mapping: <leader>tt apre terminale in un NUOVO buffer (nella stessa finestra)
vim.keymap.set("n", "<leader>tt", function()
    vim.cmd("enew | terminal | startinsert")
end, { desc = "Terminal: new buffer" })

-- Ogni volta che apri un terminale, entra subito in modalità terminale
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    callback = function()
        vim.cmd("startinsert")
    end,
})

-- Ogni volta che entri in un buffer di terminale esistente, attiva terminal mode
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "term://*",
    callback = function()
        -- Controlla se siamo effettivamente in un buffer di terminale
        if vim.bo.buftype == "terminal" then
            vim.cmd("startinsert")
        end
    end,
})
