local path = os.getenv("HOME") .. "/Documents/Nas/Obsidian"
local wsPersonal = path .. "/vaults/personal"
local wsWork = path .. "/vaults/work"

local vaults = {
  {
    name = "personal",
    path = wsPersonal,
    overrides = {
      notes_subdir = "personal/limbo", -- Subdirectory for notes
      -- Settings for daily notes
      daily_notes = {
        folder = "personal/dailies",
        default_tag = { "daily-notes" },
        template = "note_template", -- Template for daily notes
      },
      -- Settings for templates
      templates = {
        subdir = path .. "/vaults/templates", -- Subdirectory for templates
        date_format = "%Y-%m-%d-%a", -- Date format for templates
        time_format = "%H:%M", -- Time format for templates
        tags = "", -- Default tags for templates
      },
      -- Settings for files
      attachments = {
        img_folder = path .. "/vaults/files", -- Folder for image attachments
      },
    },
  },
  {
    name = "work",
    path = wsWork,
    overrides = {
      notes_subdir = "work/limbo", -- Subdirectory for notes
      -- Settings for templates
      templates = {
        subdir = path .. "/vaults/templates", -- Subdirectory for templates
        date_format = "%Y-%m-%d-%a", -- Date format for templates
        time_format = "%H:%M", -- Time format for templates
        tags = "", -- Default tags for templates
      },
    },
  },
}

local events = vim
  .iter(vaults)
  :map(function(vault)
    return vim.fn.expand(vault.path)
  end)
  :map(function(vault)
    return {
      string.format("BufReadPre %s/*.md", vault),
      string.format("BufNewFile %s/*.md", vault),
    }
  end)
  :flatten()
  :totable()

return {
  "epwalsh/obsidian.nvim",
  version = "*",
  event = events,
  cmd = {
    "ObsidianMenu",
  },
  keys = {
    { "<leader>ob", "<cmd>ObsidianMenu<cr>", desc = "Obsidian Menú" },
  },
  dependencies = {
    { "nvim-lua/plenary.nvim" },
  },
  opts = {
    workspaces = vaults,

    --Completion settings
    completion = {
      blink = true,
      min_char = 2,
    },

    new_notes_location = "notes_subdir", -- Location for new notes

    picker = {
      name = "fzf-lua",
    },

    ui = {
      enable = false,
    },

    -- Function to generate frontmatter for notes
    note_frontmatter_func = function(note)
      -- This is equivalent to the default frontmatter function.
      local out = { id = note.id, aliases = note.aliases, tags = note.tags }

      -- `note.metadata` contains any manually added fields in the frontmatter.
      -- So here we just make sure those fields are kept in the frontmatter.
      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end
      return out
    end,

    -- Function to generate note IDs
    note_id_func = function(title)
      print("NOTE TITLE: ", vim.inspect(title)) -- 👈 para debug

      -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
      -- In this case a note with the title 'My new note' will be given an ID that looks
      -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
      local suffix = ""
      if title ~= nil then
        -- If title is given, transform it into valid file name.
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        -- If title is nil, just add 4 random uppercase letters to the suffix.
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return tostring(os.time()) .. "-" .. suffix
    end,
  },

  config = function(_, opts)
    require("obsidian").setup(opts)

    local actions = {
      New_Note = "ObsidianNew",
      Today = "ObsidianToday",
      Yesterday = "ObsidianYesterday",
      Tomorrow = "ObsidianTomorrow",
      Search = "ObsidianSearch",
      Workspaces = "ObsidianWorkspace",
      Quick_Switch = "ObsidianQuickSwitch",
      Templates = "ObsidianTemplate",
      Tags = "ObsidianTags",
    }

    vim.api.nvim_create_user_command("ObsidianMenu", function()
      vim.ui.select(vim.tbl_keys(actions), { prompt = "Obsidian Action" }, function(selected)
        vim.cmd(actions[selected])
      end)
    end, {})
  end,
}
