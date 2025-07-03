return {
  {
    "JavaHello/spring-boot.nvim",
    ft = { "java", "yaml", "jproperties", "yml" },
    dependencies = {
      "mfussenegger/nvim-jdtls", -- LSP para Java
      "ibhagwan/fzf-lua", -- Opcional: UI tipo FZF
    },
    opts = {}, -- Puedes pasar opciones si deseas personalizar
  },
}
