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
      palettes = {
        astrodark = {
          ui = {
            base = "#000000",
            inactive_base = "#000000",
            float = "#000000",
          },
          term = {
            background = "#000000",
          },
        },
      },
    },
    config = function(_, opts)
      require("astrotheme").setup(opts)
    end,
  },
}
