return {
  "elmcgill/springboot-nvim",
  lazy = true,
  dependencies = {
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-jdtls",
  },
  config = function()
    local springboot_nvim = require("springboot-nvim")
    vim.keymap.set("n", "<leader>jr", springboot_nvim.boot_run, { desc = "Spring Boot Run Project" })
    vim.keymap.set("n", "<leader>jc", springboot_nvim.generate_class, { desc = "Java Create Class" })
    vim.keymap.set("n", "<leader>ji", springboot_nvim.generate_interface, { desc = "Java Create Interface" })
    vim.keymap.set("n", "<leader>je", springboot_nvim.generate_enum, { desc = "Java Create Enum" })
    vim.keymap.set("n", "<leader>ju", springboot_nvim.create_ui, { desc = "Java UI" })
    springboot_nvim.setup({})
  end,
}
