return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local startup_cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":p")

    local function startup_relative_filename()
      local name = vim.api.nvim_buf_get_name(0)

      if name == "" then
        return "[No Name]"
      end

      if name:match("^%w+://") then
        return name
      end

      local absolute = vim.fn.fnamemodify(name, ":p")

      if vim.fs and vim.fs.relpath then
        local ok, relative = pcall(vim.fs.relpath, startup_cwd, absolute)

        if ok and relative then
          return relative
        end
      end

      if absolute:sub(1, #startup_cwd) == startup_cwd then
        return absolute:sub(#startup_cwd + 1)
      end

      return vim.fn.fnamemodify(absolute, ":~")
    end

    require("lualine").setup({
      sections = {
        lualine_c = {
          startup_relative_filename,
        },
      },
    })
  end,
}
