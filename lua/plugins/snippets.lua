return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      local luasnip = require("luasnip")
      -- Carica gli snippet VSCode
      require("luasnip.loaders.from_vscode").lazy_load()
      -- Carica gli snippet personalizzati dalla cartella corrente
      require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.fn.stdpath("config") .. "/snippets" })
      -- Carica anche gli snippet Lua dalla cartella javascript.lua
      require("luasnip.loaders.from_lua").load({ paths = vim.fn.stdpath("config") .. "/snippets" })
      
      -- Usa Ctrl+K per espandere o saltare in avanti
      vim.keymap.set({ "i", "s" }, "<C-k>", function()
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        end
      end, { silent = true })
      
      -- Usa Ctrl+J per saltare indietro
      vim.keymap.set({ "i", "s" }, "<C-j>", function()
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        end
      end, { silent = true })
    end,
  },
}
