-- Fix for E475 and other diagnostic-related issues
-- This configures global diagnostic handling

-- Store the original publish diagnostics handler
local original_handler = vim.lsp.handlers["textDocument/publishDiagnostics"]

-- Create a new handler that filters problematic diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
  -- Default config if not provided
  config = config or {}
  
  -- Filter out diagnostics that might cause E475 error
  if result and result.diagnostics then
    local filtered_diagnostics = {}
    for _, diagnostic in ipairs(result.diagnostics) do
      -- Skip diagnostics with excessively long messages or that contain patterns
      -- known to cause E475 errors
      local skip = false
      
      -- Check for message length - excessively long messages might cause issues
      if diagnostic.message and #diagnostic.message > 1024 then
        skip = true
      end
      
      -- Check for specific patterns that might cause E475 in Rust projects
      if diagnostic.message and (
        diagnostic.message:match("unknown type:") or
        diagnostic.message:match("mismatched types") or
        diagnostic.message:match("non%-exhaustive patterns")
      ) then
        -- Don't skip these, but modify how they're displayed
        diagnostic.message = diagnostic.message:sub(1, 200) .. "..."
      end
      
      if not skip then
        table.insert(filtered_diagnostics, diagnostic)
      end
    end
    
    -- Replace with filtered diagnostics
    result.diagnostics = filtered_diagnostics
  end
  
  -- Call the original handler with our filtered diagnostics
  return original_handler(err, result, ctx, config)
end

-- Also update the general diagnostic config
vim.diagnostic.config({
  underline = true,
  virtual_text = false,  -- Disable virtual text to avoid E475
  signs = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
    -- Limit the width of the float window to avoid E475
    width = 80,
  },
}) 