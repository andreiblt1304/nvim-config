return {
  {
    "AstroNvim/astrotheme",
    lazy = false,
    priority = 1000,
    opts = {
      background = {
        light = "astrojupiter",
        dark = "astrodark",
      },
    },
    config = function(_, opts)
      require("astrotheme").setup(opts)
    end,
  },
}
