-- ~/.config/nvim/lua/keymaps.lua
-- Central place for all custom mappings.
-- Every section lives in its own helper so you can call only what you need.

local M = {}

-- small wrapper to keep the call sites tidy
local function map(mode, lhs, rhs, desc, bufnr)
  local opts = { desc = desc, buffer = bufnr, silent = true }
  vim.keymap.set(mode, lhs, rhs, opts)
end

----------------------------------------------------------------------------------------------------
-- LSP-specific mappings ---------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
function M.lsp(bufnr)
  -- Go-to & navigation -------------------------------------------------------
  map("n", "gd", vim.lsp.buf.definition,        "LSP: Go to definition",        bufnr)
  map("n", "gD", vim.lsp.buf.declaration,       "LSP: Go to declaration",       bufnr)
  map("n", "gI", vim.lsp.buf.implementation,    "LSP: Go to implementation",    bufnr)
  map("n", "gr", vim.lsp.buf.references,        "LSP: List references",         bufnr)
  map("n", "<leader>D", vim.lsp.buf.type_definition, "LSP: Go to type definition", bufnr)

  -- Symbols -----------------------------------------------------------------
  map("n", "<leader>ds", vim.lsp.buf.document_symbol,  "LSP: Document symbols",  bufnr)
  map("n", "<leader>ws", vim.lsp.buf.workspace_symbol, "LSP: Workspace symbols", bufnr)

  -- Refactor / actions -------------------------------------------------------
  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "LSP: Code action",  bufnr)
  map("n", "<leader>rn", vim.lsp.buf.rename,              "LSP: Rename",       bufnr)

  -- Inlay hints toggle (Neovim 0.10+) ---------------------------------------
  map("n", "<leader>th", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
  end, "LSP: Toggle inlay hints", bufnr)
end

return M