require("config.lazy")

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.updatetime = 250
vim.cmd.colorscheme("habamax")

local themes = { "shine", "habamax" }
local current = vim.fn.index(themes, vim.g.colors_name) + 1
if current == 0 then
  current = 1
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if not client then
      return
    end

    if client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end

    if client:supports_method("textDocument/documentHighlight") then
      local group = vim.api.nvim_create_augroup("lsp-document-highlight-" .. args.buf, { clear = true })

      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = args.buf,
        group = group,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "BufLeave" }, {
        buffer = args.buf,
        group = group,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        buffer = args.buf,
        group = group,
        callback = function()
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = group, buffer = args.buf })
        end,
      })
    end
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.rs",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

require('lualine').setup()

local function toggle_theme()
  current = current % #themes + 1
  local theme = themes[current]
  vim.cmd.colorscheme(theme)
  print("Switched to theme: " .. theme)
end

vim.api.nvim_create_user_command("Theme", toggle_theme, {})
