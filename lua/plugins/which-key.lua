-- This file contains the configuration for the which-key.nvim plugin in Neovim.

return {
  -- Plugin: which-key.nvim
  -- URL: https://github.com/folke/which-key.nvim
  -- Description: A Neovim plugin that displays a popup with possible keybindings of the command you started typing.
  "folke/which-key.nvim",

  event = "VeryLazy", -- Load this plugin on the 'VeryLazy' event
  opts = {
    preset = "modern",
    defaults = {},
  },

  init = function()
    -- Set the timeout for key sequences
    vim.o.timeout = true
    vim.o.timeoutlen = 300 -- Set the timeout length to 300 milliseconds
  end,

  config = function()
    local wk = require("which-key")

    wk.add({
      { "<leader>w", group = "Windows" },
      { "<leader>wr", group = "Resize" },
      { "<leader>b", group = "Buffers" },
      { "<leader>o", group = "Obsidian" },
      { "<leader>?", group = "Help" },
    })
  end,

  keys = {},
}
