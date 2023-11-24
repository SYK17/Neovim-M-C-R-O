local utils = require('utils')
local confpath = vim.fn.stdpath('config') --[[@as string]]
local datapath = vim.fn.stdpath('data') --[[@as string]]

---Read file contents
---@param path string
---@return string?
local function read_file(path)
  local file = io.open(path, 'r')
  if not file then
    return nil
  end
  local content = file:read('*a')
  file:close()
  return content
end

---Install package manager if not already installed
---@return boolean success
local function bootstrap()
  vim.g.package_path = datapath .. '/site/pack/packages/opt'
  vim.g.package_lock = confpath .. '/package-lock.json'
  local lazy_path = vim.g.package_path .. '/lazy.nvim'
  if vim.uv.fs_stat(lazy_path) then
    vim.opt.rtp:prepend(lazy_path)
    return true
  end

  local lock = read_file(vim.g.package_lock)
  local lock_data = lock and vim.json.decode(lock) or nil
  local commit = lock_data
      and lock_data['lazy.nvim']
      and lock_data['lazy.nvim'].commit
    or nil
  local url = 'https://github.com/folke/lazy.nvim.git'
  vim.notify('[plugins] installing lazy.nvim...', vim.log.levels.INFO)
  vim.fn.mkdir(vim.g.package_path, 'p')
  if
    not utils.git.execute({
      'clone',
      '--filter=blob:none',
      url,
      lazy_path,
    }, vim.log.levels.INFO).success
  then
    return false
  end
  if commit then
    utils.git.dir_execute(
      lazy_path,
      { 'checkout', commit },
      vim.log.levels.INFO
    )
  end
  vim.notify(
    '[plugins] lazy.nvim cloned to ' .. lazy_path,
    vim.log.levels.INFO
  )
  vim.opt.rtp:prepend(lazy_path)
  return true
end

---Enable modules
---@param module_names string[]
local function enable_modules(module_names)
  local config = {
    root = vim.g.package_path,
    lockfile = vim.g.package_lock,
    ui = {
      border = 'shadow',
      size = { width = 0.7, height = 0.74 },
    },
    checker = { enabled = false },
    change_detection = { notify = false },
    install = { colorscheme = { 'nano', 'cockatoo', 'dragon' } },
    performance = {
      rtp = {
        disabled_plugins = {},
      },
    },
  }
  local modules = {}
  for _, module_name in ipairs(module_names) do
    vim.list_extend(modules, require('modules.' .. module_name))
  end
  require('lazy').setup(modules, config)
end

vim.api.nvim_create_autocmd('User', {
  desc = 'Reverse/Apply local patches on updating/intalling plugins.',
  pattern = { 'LazyInstall*', 'LazyUpdate*', 'LazyRestore*' },
  group = vim.api.nvim_create_augroup('LazyPatches', {}),
  callback = function(info)
    local patches_path = vim.fs.joinpath(confpath, 'patches')
    for patch in vim.fs.dir(patches_path) do
      local patch_path = vim.fs.joinpath(patches_path, patch)
      local plugin_path =
        vim.fs.joinpath(vim.g.package_path, (patch:gsub('%.patch$', '')))
      if vim.uv.fs_stat(plugin_path) then
        utils.git.dir_execute(plugin_path, { 'restore', '.' })
        if not info.match:find('Pre$') then
          vim.notify('[plugins] applying patch ' .. patch)
          utils.git.dir_execute(plugin_path, {
            'apply',
            '--ignore-space-change',
            patch_path,
          })
        end
      end
    end
  end,
})

if not bootstrap() then
  return
end
if vim.g.vscode then
  enable_modules({
    'lib',
    'edit',
    'treesitter',
  })
else
  enable_modules({
    'lib',
    'completion',
    'debug',
    'edit',
    'lsp',
    'markup',
    'tools',
    'treesitter',
    'colorschemes',
  })
end

-- a handy abbreviation
utils.keymap.command_abbrev('lz', 'Lazy')
