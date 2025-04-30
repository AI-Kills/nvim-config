return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
    opts = {
      debug = true,
      show_help = true,
      model = "gpt-4",
      temperature = 0.1,
      system_prompt = "You are a helpful programming assistant.",
    },
    build = function()
      vim.notify("Please run ':UpdateRemotePlugins' and restart Neovim")
    end,
  },
}
