-- This file contains the workaround for cmp-ai initialization
local M = {}

M.setup = function()
    -- Only set up once
    if M.setup_done then
        return
    end

    -- Make sure nvim-cmp is loaded first
    local has_cmp, cmp = pcall(require, "cmp")
    if not has_cmp then
        -- CMP not available yet, we'll try again later
        return
    end

    -- Now safely try to load cmp_ai
    local has_cmp_ai, cmp_ai = pcall(require, "cmp_ai")
    if not has_cmp_ai then
        -- Log this, but don't error out
        vim.notify("Failed to load cmp_ai", vim.log.levels.WARN)
        return
    end

    -- Configure cmp_ai
    local opts = {
        api_key_cmd = "echo $OPENAI_API_KEY",
    }

    -- Set up cmp_ai with our options
    cmp_ai:setup(opts)

    -- Mark as done
    M.setup_done = true
end

-- Create an autocommand to initialize cmp_ai after everything is loaded
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        -- Delay the setup to ensure everything is loaded
        vim.defer_fn(function()
            M.setup()
        end, 100)
    end,
    group = vim.api.nvim_create_augroup("CmpAiSetup", { clear = true }),
    once = true,
})

-- Also try to set up on InsertEnter if not already done
vim.api.nvim_create_autocmd("InsertEnter", {
    callback = function()
        M.setup()
    end,
    group = vim.api.nvim_create_augroup("CmpAiInsertSetup", { clear = true }),
})

return M
