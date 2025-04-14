-- COMPLETIONS
--
--
--
--
return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp", -- LSP completions
    "hrsh7th/cmp-buffer", -- Buffer text completions
    "hrsh7th/cmp-path", -- Path completions
    "saadparwaiz1/cmp_luasnip", -- Snippet completions
    "L3MON4D3/LuaSnip", -- Snippet engine
    "onsails/lspkind.nvim", -- Icons in completion menu
  },

  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")
    local compare = require("cmp.config.compare")

    require("luasnip.loaders.from_vscode").lazy_load() -- Load snippets vscode style

    local snippet_names = {}
    for _, s in ipairs(luasnip.available()) do
      snippet_names[s.name] = true
    end
    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(), -- triggers completion
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Press enter to confirm
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm({ select = true })
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      formatting = {
        format = lspkind.cmp_format({ -- uses lspkind to add icons
          mode = "symbol_text",
          maxwidth = 50,
          ellipsis_char = "...", -- truncate  long labels with ellipsis
          show_labelDetails = false, -- aggiunge dettagli all'etichetta
        }),
      },
      -- Cambiato: prima luasnip, separato dagli altri
      sources = {
        { name = "luasnip", group_index = 1 },
        {
          name = "nvim_lsp",
          group_index = 2,
          entry_filter = function(entry, ctx) -- filter out every suggestion that is not a snippet
            local label = entry:get_completion_item().label or ""
            if not label:match("~") and snippet_names[label] then
              return false
            end
            return true
          end,
        },
        { name = "buffer", group_index = 2 },
        { name = "path", group_index = 2 },
      },
      sorting = {
        priority_weight = 2,
        comparators = {
          -- Source priority (per group_index)
          function(entry1, entry2)
            local source1 = entry1.source.name
            local source2 = entry2.source.name

            if source1 == "luasnip" and source2 ~= "luasnip" then
              return true
            elseif source1 ~= "luasnip" and source2 == "luasnip" then
              return false
            end

            return nil
          end,
          -- Snippet prima, basato sull'etichetta
          function(entry1, entry2)
            local label1 = entry1:get_completion_item().label or ""
            local label2 = entry2:get_completion_item().label or ""

            local has_tilde1 = label1:match("~$")
            local has_tilde2 = label2:match("~$")

            if has_tilde1 and not has_tilde2 then
              return true
            elseif not has_tilde1 and has_tilde2 then
              return false
            end

            return nil
          end,
          compare.offset,
          compare.exact,
          compare.score,
          compare.recently_used,
          compare.kind,
          compare.sort_text,
          compare.length,
          compare.order,
        },
      },
      preselect = cmp.PreselectMode.Item,
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
    })
  end,
}
