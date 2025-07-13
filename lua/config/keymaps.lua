-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local set = vim.keymap.set

-- Position cursor at the middle of the screen after scrolling half page
set("n", "<C-d>", "<C-d>zz") -- Scroll down half a page and center the cursor
set("n", "<C-u>", "<C-u>zz") -- Scroll up half a page and center the cursor

-- Better ESC
set("i", "jj", "<ESC>")

-- Move on windows
set("n", "<C-j>", "<C-w>j")
set("n", "<C-h>", "<C-w>h")
set("n", "<C-l>", "<C-w>l")
set("n", "<C-k>", "<C-w>k")

-- Resize windows
set({ "n", "v" }, "<leader>wri", "<C-w>=", { desc = "Rezise all windows" })
set({ "n", "v" }, "<leader>wrv", "<C-w>_", { desc = "Extend on Vertical view" })
set({ "n", "v" }, "<leader>wrs", "<C-w>|", { desc = "Extend on Horizontal view" })

-- Keep visual selection after indent
set("v", "<", "<gv", { desc = "Indent left and keep selection" })
set("v", ">", ">gv", { desc = "Indent right and keep selection" })

----- Explorer -----
set("n", "-", function()
  Snacks.explorer()
end, { desc = "Open Explorer" })

-- Delete all buffers but the current one
set("n", "<leader>bq", '<Esc>:%bdelete|edit #|normal`"<Return>', { desc = "Delete other buffers but the current one" })

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

-- AI
-- Atajo para Gemini CLI
set("v", "<leader>ci", "<Esc><Cmd>lua require('utils.gemini').ask_gemini()<CR>", { desc = "Ask Gemini (Visual)" })
