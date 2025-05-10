local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)   -- add to runtimepath early_

require("lazy").setup("plugins")      -- finds lua/plugins.lua

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "rust_analyzer" },  -- auto-installs servers
  automatic_installation = true,
})