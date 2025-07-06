-- lua/plugins/mason.lua

return {
  {
    "mason-org/mason.nvim",
    lazy = false,
    opts = {
      ensure_installed = {
        "java-debug-adapter",
        "java-test",
        "jdtls",
        "json-lsp", -- json-lsp
        "lua-language-server",
        "markdown-toc",
        "markdownlint-cli2",
        "marksman",
        "shfmt",
        "stylua",
      },
    },
  },

  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
    opts = {
      ensure_installed = {
        "jdtls",
        "jsonls",
        "lua_ls",
      },
      automatic_installation = true,
    },
  },

  -- Opcional: para DAP de Java si usas nvim-dap
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "mason-org/mason.nvim", "mfussenegger/nvim-dap" },
    opts = {
      ensure_installed = {
        "java-debug-adapter",
        "java-test",
      },
      automatic_setup = true,
    },
  },
}
