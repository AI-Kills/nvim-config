-- Add any autocmds here

vim.api.nvim_create_autocmd("FileType", {
    pattern = "go",
    callback = function()
        vim.keymap.set("i", "mpt", "import ()<Left>", { buffer = true })
        vim.keymap.set("i", "fnc", "func () {\n}<Up><End><Left><Left><Left><Left>", { buffer = true })
        vim.keymap.set("i", "ife", "if err != nil {\n}<Left>", { buffer = true })
        vim.keymap.set("i", "prf", 'fmt.Printf("", )<Left><Left><Left><Left>', { buffer = true })
    end,
})
