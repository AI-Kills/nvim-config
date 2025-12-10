return {
  {
    "sheerun/vim-polyglot",
    event = "VeryLazy",
    config = function()
      -- Enable Cypher syntax highlighting via vim-polyglot
      -- vim-polyglot includes cypher syntax support
      vim.g.polyglot_disabled = {} -- Ensure no languages are disabled
    end,
  },
}
