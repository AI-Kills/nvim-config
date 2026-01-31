-- Add any autocmds here

-- shortcuts globali
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    callback = function()
        vim.keymap.set("i", "done", "✅ ", { buffer = true })
    end,
})

-- shortcuts per files go
vim.api.nvim_create_autocmd("FileType", {
    pattern = "go",
    callback = function()
        vim.keymap.set("i", "_i", "import ()<Left>", { buffer = true })
        vim.keymap.set("i", "__", 'import ("fmt"; "os"; "sync")', { buffer = true })

        vim.keymap.set("i", "_f", "func () {\n}<Up><End><Left><Left><Left><Left>", { buffer = true })
        vim.keymap.set("i", "_p", 'fmt.Printf("", )<Left><Left><Left><Left>', { buffer = true })
        vim.keymap.set("i", "_err", "if err != nil {\n}<Left>", { buffer = true })
        vim.keymap.set("i", "_str", "type  struct{\n}<Up><Right><Right><Right><Right>", { buffer = true })
        vim.keymap.set("i", "_int", "type  interface{\n}<Up><Right><Right><Right><Right>", { buffer = true })
    end,
})
