return {
  "jake-stewart/multicursor.nvim",
  branch = "1.0",
  config = function()
    local mc = require("multicursor-nvim")
    mc.setup()

    local set = vim.keymap.set

    -- Add or skip adding a new cursor by matching word/selection
    set({ "n", "v" }, "<C-n>", function()
      mc.matchAddCursor(1)
    end)
    set({ "n", "v" }, "<C-m>", function()
      mc.matchSkipCursor(1)
    end)
    set({ "n", "v" }, "<C-S-N>", function()
      mc.matchAddCursor(-1)
    end)
    set({ "n", "v" }, "<C-S-M>", function()
      mc.matchSkipCursor(-1)
    end)
    set({ "n", "v" }, "<C-a>", function()
      mc.matchAllAddCursors()
    end)

    -- Mappings defined in a keymap layer only apply when there are
    -- multiple cursors. This lets you have overlapping mappings.
    mc.addKeymapLayer(function(layerSet)
      -- Enable and clear cursors using escape.
      layerSet("n", "<esc>", function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        else
          mc.clearCursors()
        end
      end)
    end)

    -- Customize how cursors look.
    local hl = vim.api.nvim_set_hl
    hl(0, "MultiCursorCursor", { reverse = true })
    hl(0, "MultiCursorVisual", { link = "Visual" })
    hl(0, "MultiCursorSign", { link = "SignColumn" })
    hl(0, "MultiCursorMatchPreview", { link = "Search" })
    hl(0, "MultiCursorDisabledCursor", { reverse = true })
    hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
  end,
}
