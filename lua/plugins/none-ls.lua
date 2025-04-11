-- lua/plugins/formatting.lua
return {
  "nvimtools/none-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local null_ls = require("null-ls")

    -- Define formatter to use.
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
      },
      on_attach = function(client, bufnr)
        -- Active only if client can formatt
        if client.supports_method("textDocument/formatting") then
          -- Delete autocmds
          local group = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
          vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })

          -- Autocmd: Formatt before to save
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = group,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
        end
      end,
    })
  end,
}
