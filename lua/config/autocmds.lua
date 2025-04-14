-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Set diagnostic highlights to use underline style
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("custom_diagnostic_highlights", { clear = true }),
  callback = function()
    -- Configure diagnostic highlight groups to use underline
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { underline = true, sp = "Red" })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { underline = true, sp = "Orange" })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { underline = true, sp = "LightBlue" })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { underline = true, sp = "Green" })
  end,
})
