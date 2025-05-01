return {
  "nvim-pack/nvim-spectre",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {
      "<leader>sr",
      function()
        require("spectre").open()
      end,
      desc = "Search and Replace (Spectre)",
    },
  },
  -- Add custom configuration to fix the buftype issue
  opts = function()
    -- Create an autocommand that removes the nofile buftype when Spectre is opened
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "spectre_panel",
      callback = function(event)
        -- Wait briefly to ensure Spectre has finished setting up
        vim.defer_fn(function()
          -- Only modify if the buffer still exists
          if vim.api.nvim_buf_is_valid(event.buf) then
            -- Change buftype to empty string to allow writing
            vim.api.nvim_buf_set_option(event.buf, "buftype", "")
            -- Add additional autocmd to ensure it stays empty after operations
            vim.api.nvim_create_autocmd("BufReadCmd", {
              buffer = event.buf,
              callback = function()
                vim.api.nvim_buf_set_option(event.buf, "buftype", "")
                return true
              end,
            })
          end
        end, 10)
      end,
    })

    -- Return configuration for Spectre
    return {
      open_cmd = "vnew", -- keep the default
      live_update = true, -- enable live update for better experience
      is_insert_mode = true, -- start in insert mode
      is_block_ui_break = false, -- safer setting to prevent UI breakage
      -- Replace engine configuration
      replace_engine = {
        -- Use sed as the default engine on macOS
        -- (This helps ensure consistent behavior)
        ["sed"] = {
          cmd = vim.fn.executable("gsed") == 1 and "gsed" or "sed",
          args = nil,
        }
      }
    }
  end,
  -- Ensure plugin is loaded at startup for the autocmd to work
  event = "VeryLazy",
}
