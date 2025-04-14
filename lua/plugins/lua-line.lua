return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  opts = {
    options = {
      theme = "horizon",
    },
    sections = {
      lualine_a = {
        {
          "mode",
          icon = "󰘦 ",
        },
      },
    },
  },
}
