-- lua/custom/plugins/emmet.lua
return {
    {
        "mattn/emmet-vim",
        ft = { "html", "css", "javascriptreact", "typescriptreact", "vue", "svelte" },
        init = function()
            -- imposta leader Emmet (default <C-y>)
            vim.g.user_emmet_leader_key = "<C-y>"
            -- disabilita global install
            vim.g.user_emmet_install_global = 0
        end,
        config = function()
            -- abilita solo per i ft dichiarati
            vim.cmd([[autocmd FileType html,css,javascriptreact,typescriptreact,vue,svelte EmmetInstall]])
        end,
    },
    {
        {
            "windwp/nvim-ts-autotag",
            ft = { "html", "javascriptreact", "typescriptreact", "vue", "svelte", "xml" },
            config = function()
                require("nvim-ts-autotag").setup()
            end,
        },
    },
}
