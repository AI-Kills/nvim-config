return {

  -- Override default LSP configuration
  {
    "neovim/nvim-lspconfig",
    init = function()
      -- Customize diagnostic display
      local diagnostic_config = {
        underline = true,
        virtual_text = false, -- Disable virtual text (inline diagnostics)
        signs = false,
        update_in_insert = false,
        severity_sort = true,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      }
      vim.diagnostic.config(diagnostic_config)
      -- Create autocommand to show diagnostics in floating window only when cursor is on the line
      vim.api.nvim_create_autocmd("CursorHold", {
        group = vim.api.nvim_create_augroup("show_diagnostics_on_cursor_hold", { clear = true }),
        callback = function()
          local line = vim.api.nvim_win_get_cursor(0)[1] - 1
          local diagnostics = vim.diagnostic.get(0, { lnum = line })
          if #diagnostics > 0 then
            vim.diagnostic.open_float(nil, { focus = false, scope = "line" })
          end
        end,
      })
    end,
  },
}
