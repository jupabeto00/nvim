return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp", -- source LSP
    "hrsh7th/cmp-buffer", -- source buffer
    "hrsh7th/cmp-path", -- source file path
    "saadparwaiz1/cmp_luasnip", -- source snippets
    {
      "L3MON4D3/LuaSnip",
      run = "make install_jsregexp",
      dependencies = {
        "rafamadriz/friendly-snippets",
      },
    }, -- engine de snippets
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    -- load snippets by default
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
      }, {
        { name = "buffer" },
        { name = "path" },
      }),
    })
  end,
}
