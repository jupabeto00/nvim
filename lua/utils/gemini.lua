local M = {}

---@class GeminiOptions
---@field cmd string | fun(prompt: string, selection: string):string
---@field window { width: number, height: number, border: string, style: string }

---@type GeminiOptions
local default_opts = {
  -- Asume que 'gemini' está en tu PATH.
  -- El primer '%s' es el prompt, el segundo es la selección.
  cmd = 'gemini -p "%s"',
  window = {
    width = 0.8,
    height = 0.8,
    border = "rounded",
    style = "minimal",
  },
}

--- Pide a Gemini una respuesta basada en un prompt y una selección de texto.
-- La respuesta se muestra en una ventana flotante.
function M.ask_gemini()
  local selection = M.get_visual_selection()
  if selection == "" then
    vim.notify("No hay texto seleccionado.", vim.log.levels.WARN)
    return
  end

  -- Prepara un texto de prompt con contexto
  local context_preview = selection:gsub("\n", " "):sub(1, 50)
  local prompt_text = string.format("Pregunta a Gemini (contexto: %s...): ", context_preview)

  vim.ui.input({ prompt = prompt_text }, function(prompt)
    if not prompt or prompt == "" then
      vim.notify("Prompt cancelado.", vim.log.levels.WARN)
      return
    end

    -- El comando usa la selección completa, no la previsualización.
    local command = string.format(default_opts.cmd, prompt .. " ```" .. selection .. "```")
    vim.notify("Consultando a Gemini...  ->" .. command, vim.log.levels.INFO)

    local output = {}
    vim.fn.jobstart(command, {
      stdout_buffered = true,
      stderr_buffered = true,
      on_stdout = function(_, data)
        if data then
          for _, line in ipairs(data) do
            if line ~= "" then
              table.insert(output, line)
            end
          end
        end
      end,
      on_stderr = function(_, data)
        if data and data[1] ~= "" then
          vim.notify("Error de gemini: " .. table.concat(data, "\n"), vim.log.levels.ERROR)
        end
      end,
      on_exit = function(_, code)
        if code ~= 0 then
          vim.notify("gemini terminó con código de error: " .. code, vim.log.levels.ERROR)
          return
        end

        vim.schedule(function()
          M.show_in_float(output)
        end)
      end,
    })
  end)
end

--- Muestra el texto en una ventana flotante.
---@param lines string[]
function M.show_in_float(lines)
  local width = vim.api.nvim_get_option("columns")
  local height = vim.api.nvim_get_option("lines")

  local win_width = math.floor(width * default_opts.window.width)
  local win_height = math.floor(height * default_opts.window.height)

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = win_width,
    height = win_height,
    row = (height - win_height) / 2,
    col = (width - win_width) / 2,
    style = default_opts.window.style,
    border = default_opts.window.border,
  })
end

--- Obtiene la selección visual actual de forma robusta, manejando todos los modos.
---@return string
function M.get_visual_selection()
  local mode = vim.fn.visualmode()
  print(mode)
  if mode == "" then
    return ""
  end

  local pos_start = vim.fn.getpos("'<")
  local pos_end = vim.fn.getpos("'>")
  local start_row, start_col = pos_start[2], pos_start[3]
  local end_row, end_col = pos_end[2], pos_end[3]

  if start_row == 0 then
    return ""
  end

  local lines = vim.api.nvim_buf_get_lines(0, start_row - 1, end_row, false)
  if #lines == 0 then
    return ""
  end

  -- Modo Línea ('V')
  if mode == "V" then
    return table.concat(lines, "\n")
  end

  -- Modo Bloque ('<C-v>')
  if mode == "\22" then -- Ctrl-V se representa como el byte 22
    local block_lines = {}
    local min_col = math.min(start_col, end_col)
    local max_col = math.max(start_col, end_col)
    for _, line in ipairs(lines) do
      -- Extrae el texto del bloque, teniendo en cuenta el ancho de los caracteres.
      local line_text = vim.fn.strcharpart(line, min_col - 1, max_col - min_col + 1)
      table.insert(block_lines, line_text)
    end
    return table.concat(block_lines, "\n")
  end

  -- Modo Caracter ('v')
  if #lines == 1 then
    return string.sub(lines[1], start_col, end_col)
  else
    lines[1] = string.sub(lines[1], start_col)
    lines[#lines] = string.sub(lines[#lines], 1, end_col)
    return table.concat(lines, "\n")
  end
end

-- Pequeño hack para registrar el modulo y que se pueda requerir con 'require("utils.gemini")'
package.loaded["utils.gemini"] = M

return M
