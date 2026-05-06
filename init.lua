vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("config.lazy")

vim.lsp.config("buf_ls", {
  cmd = { "buf", "lsp", "serve" },
  filetypes = { "proto" },
  root_markers = { "buf.yaml", ".git" },
})
vim.lsp.enable("buf_ls")

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
vim.opt.pummaxwidth = 40
vim.opt.updatetime = 250
vim.opt.autoread = true
vim.opt.cmdheight = 0

local file_watch_group = vim.api.nvim_create_augroup("file-watch", { clear = true })

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "TermClose", "TermLeave" }, {
  group = file_watch_group,
  callback = function()
    if vim.fn.mode() ~= "c" then
      vim.cmd.checktime()
    end
  end,
})

vim.api.nvim_create_autocmd("FileChangedShellPost", {
  group = file_watch_group,
  callback = function()
    vim.notify("File changed on disk. Buffer reloaded.", vim.log.levels.INFO, { title = "nvim" })
  end,
})

local preferred_colorscheme = "astrodark"
if not pcall(vim.cmd.colorscheme, preferred_colorscheme) then
  vim.cmd.colorscheme("habamax")
end

function _G.SmartInsertCR()
  local ok, npairs = pcall(require, "nvim-autopairs")

  if vim.fn.pumvisible() == 1 then
    if vim.fn.complete_info({ "selected" }).selected ~= -1 then
      if ok then
        return npairs.esc("<C-y>")
      end

      return "<C-y>"
    end

    if ok then
      return npairs.esc("<C-e>") .. npairs.autopairs_cr()
    end

    return "<C-e><CR>"
  end

  if ok then
    return npairs.autopairs_cr()
  end

  return "<CR>"
end

vim.api.nvim_set_keymap("i", "<CR>", "v:lua.SmartInsertCR()", {
  expr = true,
  noremap = true,
  silent = true,
})

for _, mode in ipairs({ "i", "c" }) do
  vim.keymap.set(mode, "<M-BS>", "<C-w>", { desc = "Delete previous word" })
  vim.keymap.set(mode, "<M-Del>", "<C-w>", { desc = "Delete previous word" })
  vim.keymap.set(mode, "<D-BS>", "<C-u>", { desc = "Delete to start of line" })
  vim.keymap.set(mode, "<D-Del>", "<C-u>", { desc = "Delete to start of line" })
end

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

    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, {
        buffer = args.buf,
        silent = true,
        desc = desc,
      })
    end

    if client:supports_method("textDocument/hover") then
      map("n", "K", vim.lsp.buf.hover, "LSP hover")
    end

    if client:supports_method("textDocument/definition") then
      map("n", "gd", vim.lsp.buf.definition, "Go to definition")
    end

    if client:supports_method("textDocument/declaration") then
      map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
    end

    if client:supports_method("textDocument/references") then
      map("n", "gr", vim.lsp.buf.references, "Find references")
    end

    if client:supports_method("textDocument/implementation") then
      map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
    end

    if client:supports_method("textDocument/typeDefinition") then
      map("n", "gt", vim.lsp.buf.type_definition, "Go to type definition")
    end

    if client:supports_method("textDocument/completion") and not vim.g.use_cmp_completion then
      vim.lsp.completion.enable(true, client.id, args.buf, {
        autotrigger = true,
      })

      map("i", "<C-Space>", function()
        vim.lsp.completion.get()
      end, "Trigger completion")
    end

    if client:supports_method("textDocument/codeAction") then
      map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, "Code actions")
    end

    if client:supports_method("textDocument/rename") then
      map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
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
