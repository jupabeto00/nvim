return {
  "williamboman/mason.nvim",
  enabled = true,
  dependencies = {
    { "williamboman/mason-lspconfig.nvim", enabled = true },
    { "WhoIsSethDaniel/mason-tool-installer.nvim", enabled = true },
  },
  config = function()
    require("mason").setup()

    -- You can add other tools here that you want Mason to install
    -- for you, so that they are available from within Neovim.
    local ensure_installed = {}
    vim.list_extend(ensure_installed, {
    "stylua", -- Used to format Lua code
    })

    require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "ts_ls",
        -- "pylsp",
        "nil_ls",
      },
    })
  end,
}
