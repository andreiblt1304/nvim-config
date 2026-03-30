local function rust_analyzer_cmd()
  local default_toolchain = vim.system({ 'rustup', 'default' }, { text = true }):wait()
  local toolchain = (default_toolchain.stdout or ''):match('^(%S+)')

  if toolchain then
    local rust_analyzer = vim.system(
      { 'rustup', 'which', 'rust-analyzer', '--toolchain', toolchain },
      { text = true }
    ):wait()
    local path = vim.trim(rust_analyzer.stdout or '')

    if rust_analyzer.code == 0 and path ~= '' then
      return { path }
    end
  end

  return { 'rust-analyzer' }
end

return {
  { 'rust-lang/rust.vim' },
  {
    'mrcjkb/rustaceanvim',
    version = '^8', -- Recommended
    lazy = false, -- This plugin is already lazy
    init = function()
      ---@type rustaceanvim.Opts
      vim.g.rustaceanvim = {
        server = {
          cmd = rust_analyzer_cmd,
          default_settings = {
            ['rust-analyzer'] = {
              cargo = {
                features = 'all',
              },
            },
          },
        },
      }
    end,
  },
}
