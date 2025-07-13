return {
  "saghen/blink.cmp",
  opts = {
    cmdline = {
      enabled = true,
      completion = {
        ghost_text = {
          enabled = true,
        },
        menu = {
          auto_show = true,
        },
      },
      keymap = {
        ["<Tab>"] = { "show", "select_next" },
        ["<S-Tab>"] = { "show", "select_prev" },
        ["<CR>"] = { "accept_and_enter", "fallback" },
      },
    },
  },
}
