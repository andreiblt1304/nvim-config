-- somewhere after you require mason-lspconfig
local keymaps = require("keybinds")

require("mason-lspconfig").setup_handlers({
  function(server)
    require("lspconfig")[server].setup({
      on_attach = function(_, bufnr)
        keymaps.lsp(bufnr) 
      end,
    })
  end,
})