-- This file contains custom key mappings for Neovim.
local leader = " "
local vk = vim.keymap

-- Position cursor at the middle of the screen after scrolling half page
vk.set("n", "<C-d>", "<C-d>zz") -- Scroll down half a page and center the cursor
vk.set("n", "<C-u>", "<C-u>zz") -- Scroll up half a page and center the cursor

-- Map Ctrl+b in insert mode to delete to the end of the word without leaving insert mode
vk.set("i", "<C-b>", "<C-o>de")

-- Map Ctrl+c to escape from other modes
-- vk.set({ "i", "n", "v" }, "<C-c>", [[<C-\><C-n>]])

-- Better ESC
vk.set("i", "jj", "<ESC>")

-- Better close window
vk.set({ "i", "n", "v" }, "<leader>q", "<C-w>q", { desc = "Close Window" })

-- Move on windows
vk.set("n", "<C-j>", "<C-w>j")
vk.set("n", "<C-h>", "<C-w>h")
vk.set("n", "<C-l>", "<C-w>l")
vk.set("n", "<C-k>", "<C-w>k")

-- Better split windows
vk.set("n", "<leader>ws", "<C-w>s", { desc = "Split Horizontal" })
vk.set("n", "<leader>wv", "<C-w>v", { desc = "Split Vertical" })

-- Resize windows
vk.set({ "n", "v" }, "<leader>wri", "<C-w>=", { desc = "Rezise all windows" })
vk.set({ "n", "v" }, "<leader>wrv", "<C-w>_", { desc = "Extend on Vertical view" })
vk.set({ "n", "v" }, "<leader>wrs", "<C-w>|", { desc = "Extend on Horizontal view" })

-- Keep visual selection after indent
vk.set("v", "<", "<gv", { desc = "Indent left and keep selection" })
vk.set("v", ">", ">gv", { desc = "Indent right and keep selection" })

----- LAZY -----
vk.set("n", "<leader>l", "<CMD>Lazy<CR>", { desc = "Lazy" })

----- MASON -----
vk.set("n", "<leader>m", "<CMD>Mason<CR>", { desc = "Mason" })

----- OBSIDIAN -----
vk.set(
  "n",
  "<leader>oc",
  "<cmd>lua require('obsidian').util.toggle_checkbox()<CR>",
  { desc = "Obsidian Check Checkbox" }
)
vk.set("n", "<leader>ot", "<cmd>ObsidianTemplate<CR>", { desc = "Insert Obsidian Template" })
vk.set("n", "<leader>oo", "<cmd>ObsidianOpen<CR>", { desc = "Open in Obsidian App" })
vk.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<CR>", { desc = "Show ObsidianBacklinks" })
vk.set("n", "<leader>ol", "<cmd>ObsidianLinks<CR>", { desc = "Show ObsidianLinks" })
vk.set("n", "<leader>on", "<cmd>ObsidianNew<CR>", { desc = "Create New Note" })
vk.set("n", "<leader>os", "<cmd>ObsidianSearch<CR>", { desc = "Search Obsidian" })
vk.set("n", "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>", { desc = "Quick Switch" })

----- OIL -----
vk.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Delete all buffers but the current one
vk.set(
  "n",
  "<leader>bq",
  '<Esc>:%bdelete|edit #|normal`"<Return>',
  { desc = "Delete other buffers but the current one" }
)

-- Disable key mappings in insert mode
vim.api.nvim_set_keymap("i", "<A-j>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<A-k>", "<Nop>", { noremap = true, silent = true })

-- Disable key mappings in normal mode
vim.api.nvim_set_keymap("n", "<A-j>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-k>", "<Nop>", { noremap = true, silent = true })

-- Disable key mappings in visual block mode
vim.api.nvim_set_keymap("x", "<A-j>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "<A-k>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "J", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "K", "<Nop>", { noremap = true, silent = true })

-- Redefine Ctrl+s to save with the custom function
vim.api.nvim_set_keymap("n", "<C-s>", ":lua SaveFile()<CR>", { noremap = true, silent = true })

-- Custom save function
function SaveFile()
  -- Check if a buffer with a file is open
  if vim.fn.empty(vim.fn.expand("%:t")) == 1 then
    vim.notify("No file to save", vim.log.levels.WARN)
    return
  end

  local filename = vim.fn.expand("%:t") -- Get only the filename
  local success, err = pcall(function()
    vim.cmd("silent! write") -- Try to save the file without showing the default message
  end)

  if success then
    vim.notify(filename .. " Saved!") -- Show only the custom message if successful
  else
    vim.notify("Error: " .. err, vim.log.levels.ERROR) -- Show the error message if it fails
  end
end
