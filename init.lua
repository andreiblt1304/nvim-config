vim.opt.number = true        
vim.opt.relativenumber = true 
vim.opt.clipboard = "unnamedplus"
vim.cmd.colorscheme("habamax")

local themes = { "shine", "habamax" }
local current = vim.fn.index(themes, vim.g.colors_name) + 1
if current == 0 then
  current = 1  
end

local function toggle_theme()
  current = current % #themes + 1
  local theme = themes[current]
  vim.cmd.colorscheme(theme)
  print("Switched to theme: " .. theme)
end

vim.api.nvim_create_user_command("Sth", toggle_theme, {})
