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
      highlights = {
        global = {
          modify_hl_groups = function(hl, c)
            local notify_levels = { "ERROR", "WARN", "INFO", "DEBUG", "TRACE" }

            hl.NotifyBackground = { fg = c.ui.text, bg = c.ui.base }
            hl.NotifyLogTime = { fg = c.ui.text_inactive, bg = c.ui.base }
            hl.NotifyLogTitle = { fg = c.ui.blue, bg = c.ui.base }

            for _, level in ipairs(notify_levels) do
              local body = hl["Notify" .. level .. "Body"] or {}
              local border = hl["Notify" .. level .. "Border"] or {}
              local icon = hl["Notify" .. level .. "Icon"] or {}
              local title = hl["Notify" .. level .. "Title"] or {}

              body.bg = c.ui.base
              border.bg = c.ui.base
              icon.bg = c.ui.base
              title.bg = c.ui.base

              hl["Notify" .. level .. "Body"] = body
              hl["Notify" .. level .. "Border"] = border
              hl["Notify" .. level .. "Icon"] = icon
              hl["Notify" .. level .. "Title"] = title
            end
          end,
        },
      },
    },
    config = function(_, opts)
      require("astrotheme").setup(opts)
    end,
  },
}
