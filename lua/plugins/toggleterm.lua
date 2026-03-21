local lazygit
local right_terminal

local function toggle_lazygit()
  if vim.fn.executable("lazygit") == 0 then
    vim.notify("lazygit is not installed or not in PATH", vim.log.levels.ERROR)
    return
  end

  if not lazygit then
    local Terminal = require("toggleterm.terminal").Terminal

    lazygit = Terminal:new({
      cmd = "lazygit",
      direction = "float",
      hidden = true,
      float_opts = {
        border = "curved",
      },
      on_open = function()
        vim.cmd("startinsert!")
      end,
    })
  end

  lazygit:toggle()
end

local function toggle_right()
  local splitright = vim.o.splitright

  vim.o.splitright = true

  if not right_terminal then
    local Terminal = require("toggleterm.terminal").Terminal

    right_terminal = Terminal:new({
      cmd = vim.o.shell,
      direction = "vertical",
      -- size = function()
      --   return math.floor(vim.o.columns * 2)
      -- end,
      hidden = true,
      on_open = function()
        vim.cmd("startinsert!")
      end,
    })
  end

  right_terminal:toggle()
  vim.o.splitright = splitright
end

return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      start_in_insert = true,
      persist_size = true,
      shade_terminals = true,
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)

      vim.keymap.set("n", "<leader>lg", toggle_lazygit, {
        desc = "Open lazygit in a floating terminal",
        silent = true,
      })

      vim.keymap.set("n", "<leader>tl", toggle_right, {
        desc = "Open terminal in a right split",
        silent = true,
      })
    end,
  },
}
