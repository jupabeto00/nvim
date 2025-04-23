-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--
vim.api.nvim_create_user_command("GradleTestCurrentMethod", function()
  local file_path = vim.fn.expand("%:p")
  local class_path = file_path:match("src/test/java/(.*)%.java$")
  if not class_path then
    print("Este archivo no parece estar bajo src/test/java")
    return
  end
  local package = class_path:gsub("/", ".")

  local line = vim.fn.line(".")
  local method = ""

  for i = line, 1, -1 do
    local current_line = vim.fn.getline(i)
    local name = current_line:match("void%s+([%w_]+)%s*%(")
    if name then
      method = name
      break
    end
  end

  if method == "" then
    print("No se encontró ningún método de test en este archivo.")
    return
  end

  local full_test = package .. "." .. method
  local cmd = './gradlew test --tests "' .. full_test .. '"'

  vim.cmd("botright split | terminal " .. cmd)
end, {})
