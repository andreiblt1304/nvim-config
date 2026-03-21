return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local api = require("nvim-tree.api")
    local function open_project_tree()
      if #vim.api.nvim_list_uis() == 0 then
        return
      end

      if vim.fn.argc() ~= 1 then
        return
      end

      local directory = vim.fn.argv(0)
      if vim.fn.isdirectory(directory) == 0 then
        return
      end

      local path = vim.fn.fnamemodify(directory, ":p")
      local current_buf = vim.api.nvim_get_current_buf()
      local current_name = vim.api.nvim_buf_get_name(current_buf)

      vim.cmd.cd(path)

      if current_name ~= "" and vim.fn.isdirectory(current_name) == 1 then
        vim.cmd.enew()
        pcall(vim.api.nvim_buf_delete, current_buf, { force = true })
      end

      vim.schedule(function()
        api.tree.open({ path = path })
      end)
    end

    require("nvim-tree").setup({
      disable_netrw = true,
      hijack_netrw = true,
      hijack_directories = {
        enable = false,
        auto_open = false,
      },
      view = {
        float = {
          enable = true,
          quit_on_focus_loss = true,
          open_win_config = function()
            local width = math.floor(vim.o.columns * 0.5)
            local height = math.floor(vim.o.lines * 0.65)

            return {
              relative = "editor",
              border = "rounded",
              width = width,
              height = height,
              row = math.floor((vim.o.lines - height) / 2 - 1),
              col = math.floor((vim.o.columns - width) / 2),
            }
          end,
        },
      },
    })

    vim.api.nvim_create_autocmd("VimEnter", {
      once = true,
      callback = open_project_tree,
    })

    vim.keymap.set("n", "<leader>ft", function()
      api.tree.toggle({ focus = true })
    end, {
      desc = "Toggle centered file tree",
      silent = true,
    })
  end,
}
