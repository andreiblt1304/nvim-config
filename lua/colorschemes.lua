return {
  {
    "folke/tokyonight.nvim",
    priority = 1000,    -- ensure the theme loads before other highlights
    lazy = false,       -- load immediately at startup
    config = function()
      -- activate the colourscheme and tweak comment style
      vim.cmd([[colorscheme tokyonight-night]])
      vim.cmd([[hi Comment gui=none]])
    end,
  },
}