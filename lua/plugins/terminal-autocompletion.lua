-- Mapping per completamento terminale che accetta solo la prima parola
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "term://*",
    callback = function(ev)
        -- Mapping 'h' per accettare solo la prima parola del suggerimento zsh
        vim.keymap.set("t", "<Tab>", function()
            -- In zsh, Alt+F (M-f) accetta solo la prossima parola del suggerimento
            -- Proviamo prima Alt+F per accettare una parola
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<M-f>", true, false, true), "t", false)
        end, { buffer = ev.buf, silent = true })
    end,
})

return {}
