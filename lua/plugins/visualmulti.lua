return {
    "mg979/vim-visual-multi",
    init = function()
        vim.g.VM_default_mappings = 0 -- disabilita i mappings di default

        -- Definisci i tuoi mapping personalizzati sotto <leader>m
        -- === NORMAL MODE ===
        vim.keymap.set("n", "<leader>mn", "<Plug>(VM-Fnd-Under)", { desc = "Multi: Seleziona parola" })
        vim.keymap.set("n", "<leader>ma", "<Plug>(VM-Select-All)", { desc = "Multi: Seleziona tutte le occorrenze" })
        vim.keymap.set("n", "<leader>mj", "<Plug>(VM-Find-Next)", { desc = "Multi: Prossima occorrenza" })
        vim.keymap.set("n", "<leader>j", "<Plug>(VM-Add-Cursor-Down)", { desc = "Multi: Cursore giù" })
        vim.keymap.set("n", "<leader>k", "<Plug>(VM-Add-Cursor-At-Pos)k", { desc = "Multi: Cursore su" })
        vim.keymap.set("n", "<leader>mk", "<Plug>(VM-Find-Prev)", { desc = "Multi: Occorrenza precedente" })
        vim.keymap.set("n", "<leader>md", "<Plug>(VM-Remove-Last-Cursor)", { desc = "Multi: Rimuovi ultimo cursore" })

        -- === VISUAL MODE ===
        vim.keymap.set(
            "v",
            "<leader>ma",
            "<Plug>(VM-Visual-All)",
            { desc = "Multi: Tutte le occorrenze del selezionato" }
        )
    end,
}
