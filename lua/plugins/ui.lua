return {
  --Snacks
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      specs = {
        priority = 1000,
      },
      statuscolumn = {
        left = { "mark", "sign" }, -- priority of signs on the left (high to low)
        right = { "fold", "git" }, -- priority of signs on the right (high to low)
        folds = {
          open = false, -- show open fold icons
          git_hl = false, -- use Git Signs hl for fold icons
        },
        git = {
          -- patterns to match Git signs
          patterns = { "GitSign", "MiniDiffSign" },
        },
        refresh = 50, -- refresh at most every 50ms
      },
      indent = {
        only_scope = true,
        only_current = true,
      },
      image = {},
      picker = {
        matcher = {
          fuzzy = true,
          smartcase = true,
          ignorecase = true,
          filename_bonus = true,
        },
        sources = {
          explorer = {
            matcher = {
              fuzzy = true, -- Enables fuzzy matching, so you can be a bit imprecise with your search terms
              smartcase = true, -- If your search term has uppercase letters, the search becomes case-sensitive
              ignorecase = true, -- Ignores case when searching, unless smartcase is triggered
              filename_bonus = true, -- Gives a higher priority to matches in filenames
              sort_empty = false, -- If no matches are found, it won't sort the results
            },
          },
        },
      },
      dashboard = {
        sections = {
          { section = "header" },
          { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          { section = "startup" },
        },
        preset = {
          header = [[

 ▄▄▄██▀▀▀ █    ██  ▄▄▄       ███▄    █ 
   ▒██    ██  ▓██▒▒████▄     ██ ▀█   █ 
   ░██   ▓██  ▒██░▒██  ▀█▄  ▓██  ▀█ ██▒
▓██▄██▓  ▓▓█  ░██░░██▄▄▄▄██ ▓██▒  ▐▌██▒
 ▓███▒   ▒▒█████▓  ▓█   ▓██▒▒██░   ▓██░
 ▒▓▒▒░   ░▒▓▒ ▒ ▒  ▒▒   ▓▒█░░ ▒░   ▒ ▒ 
 ▒ ░▒░   ░░▒░ ░ ░   ▒   ▒▒ ░░ ░░   ░ ▒░
 ░ ░ ░    ░░░ ░ ░   ░   ▒      ░   ░ ░ 
 ░   ░      ░           ░  ░         ░ 
                                       
          ]],
          -- stylua: ignore
          ---@type snacks.dashboard.Item[]
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            -- { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
    }
  },

  --Mini animate
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      local animate = require("mini.animate")
      animate.setup({
        scroll = {
          enable= false,
        },
      })
    end,
  },

  -- Lua line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        theme = 'horizon',
      },
      sections = {
        lualine_a = {
          {
            "mode",
            icon = "󰘦 "
          }
        },
      },
    },
  },

  -- Noice
  {
    -- lazy.nvim
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fall
      "rcarriga/nvim-notify",
    }
  },
}
