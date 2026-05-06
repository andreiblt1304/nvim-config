return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    lsp = {
      signature = {
        auto_open = {
          enabled = false,
        },
      },
    },
    routes = {
      {
        filter = {
          event = "msg_show",
          any = {
            { kind = "", find = "written" },
            { kind = "", find = "fewer lines?" },
            { kind = "", find = "more lines?" },
            { kind = "", find = "lines? yanked" },
          },
        },
        opts = { skip = true },
      },
    },
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
  },
}
