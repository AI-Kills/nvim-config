return {
    "mg979/vim-visual-multi",
    init = function()
        vim.g.VM_default_mappings = 0 -- disabilita i mappings di default

        -- === NORMAL MODE ===
        vim.keymap.set("n", "µa", "<Plug>(VM-Select-All)", { desc = "Multi: Seleziona tutte le occorrenze" })
        vim.keymap.set("n", "µj", "<Plug>(VM-Add-Cursor-Down)", { desc = "Multi: Cursore giù" })
        vim.keymap.set(
            "n",
            "µn",
            "<Plug>(VM-Find-Under)<Plug>(VM-Find-Next)",
            { desc = "Multi: seleziona occorrenza successiva" }
        )
    end,
}
