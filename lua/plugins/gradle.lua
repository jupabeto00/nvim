return {
  "oclay1st/gradle.nvim",
  cmd = { "Gradle", "GradleExec", "GradleInit" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  opts = {}, -- options, see default configuration
  keys = { { "<Leader>jgg", "<cmd>Gradle<cr>", desc = "Gradle" } },
}
