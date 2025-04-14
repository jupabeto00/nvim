-- This file contains the configuration for the which-key.nvim plugin in Neovim.

return {
  -- Plugin: which-key.nvim
  -- URL: https://github.com/folke/which-key.nvim
  -- Description: A Neovim plugin that displays a popup with possible keybindings of the command you started typing.
  "folke/which-key.nvim",

  opts = {
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
      { "<leader>b", group = "[B]uffers", icon = { icon = "" } },
      { "<leader>c", group = "[C]ode", icon = { icon = "" } },
      { "<leader>d", group = "[D]ebug", icon = { icon = "" } },
      { "<leader>f", group = "[F]ind", icon = { icon = "󰱼" } },
      { "gs", group = "[S]urround", icon = { icon = "󰗅" } },
      { "<leader>g", group = "[G]it", icon = { icon = "" } },
      { "<leader>o", group = "[O]bsidian", icon = { icon = "" } },
      { "<leader>q", group = "[Q]uit", icon = { icon = "󰈆" } },
      { "<leader>u", group = "[U]i", icon = { icon = "" } },
      { "<leader>s", group = "[S]earch", icon = { icon = "" } },
      { "<leader>w", group = "[W]indow", icon = { icon = "󱂬" } },
      { "<leader>wr", group = "[W]indow [R]esize", icon = { icon = "󰙕" } },
    })
  end,

  keys = {},
}
