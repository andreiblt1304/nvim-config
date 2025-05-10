-- ~/.config/nvim/lua/plugins.lua
return {
    -- Plugin manager ------------------------------------------------------------
    { "folke/lazy.nvim",          version = false },         -- manager manages itself
  
    -- LSP/DAP/formatter installer ----------------------------------------------
    { "mason-org/mason.nvim",  build = ":MasonUpdate" },  -- optional updates
    { "mason-org/mason-lspconfig.nvim" },
  
    -- Rust development ----------------------------------------------------------
    { "mrcjkb/rustaceanvim",      ft = { "rust" } },         -- loads only on Rust files
  }