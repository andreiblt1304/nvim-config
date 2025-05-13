-- somewhere after you require mason-lspconfig
local keymaps = require("keybinds")

require("mason-lspconfig").setup({
  -- automatically install these servers on first run
  ensure_installed = { "lua_ls", "rust_analyzer" },

  -- handler for each installed server: apply our on_attach callback
  handlers = {
    function(server)
      require("lspconfig")[server].setup({
        on_attach = function(_, bufnr)
          print("✔️ LSP attached to buffer", bufnr)
          keymaps.lsp(bufnr)
        end,
      })
    end,
  },
})