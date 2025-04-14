return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        local theme = require("themes.cursor_dark")
        vim.opt.background = theme.background
        for group, opts in pairs(theme.highlights) do
          vim.api.nvim_set_hl(0, group, opts)
        end
      end,
    },
  },
}
