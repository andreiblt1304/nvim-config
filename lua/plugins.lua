-- ~/.config/nvim/lua/plugins.lua
return {
    -- Plugin manager ------------------------------------------------------------
    { "folke/lazy.nvim", version = false },
    { "mason-org/mason.nvim" },
    { "mason-org/mason-lspconfig.nvim" },
    { "nvim-telescope/telescope.nvim", dependencies = {"nvim-lua/plenary.nvim"} },
    { "mrcjkb/rustaceanvim",      ft = { "rust" } },
    { import = "colorschemes" },
  }