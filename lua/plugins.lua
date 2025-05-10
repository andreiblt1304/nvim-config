-- ~/.config/nvim/lua/plugins.lua
return {
    -- Plugin manager ------------------------------------------------------------
    { "folke/lazy.nvim", version = false },
    { "mason-org/mason.nvim",  build = ":MasonUpdate" },
    { "mason-org/mason-lspconfig.nvim" },
    { "mrcjkb/rustaceanvim",      ft = { "rust" } },
  }