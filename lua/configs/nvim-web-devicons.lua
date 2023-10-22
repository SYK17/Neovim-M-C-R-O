local icons = require('utils.static').icons

require('nvim-web-devicons').setup({
  override = {
    default_icon = {
      icon = vim.trim(icons.File),
      name = 'Default',
    },
    desktop = {
      color = '#563d7c',
      cterm_color = '60',
      icon = vim.trim(icons.Desktop),
      name = 'DesktopEntry',
    },
    lock = {
      color = '#bbbbbb',
      cterm_color = '250',
      icon = vim.trim(icons.Lock),
      name = 'Lock',
    },
    git = {
      color = '#e84d31',
      cterm_color = '196',
      icon = vim.trim(icons.Git),
      name = 'GitLogo',
    },
    commit_editmsg = {
      color = '#e84d31',
      cterm_color = '239',
      icon = vim.trim(icons.Git),
      name = 'GitCommit',
    },
  },
  override_by_extension = {
    cu = {
      color = '#76b900',
      cterm_color = '2',
      icon = vim.trim(icons.Cuda),
      name = 'Cuda',
    },
    raw = {
      color = '#ff9800',
      cterm_color = '208',
      icon = vim.trim(icons.Raw),
      name = 'Raw',
    },
    dat = {
      color = '#6dcde8',
      cterm_color = '81',
      icon = vim.trim(icons.Data),
      name = 'Data',
    },
    el = {
      color = '#a374ea',
      cterm_color = '61',
      icon = vim.trim(icons.Elisp),
      name = 'Elisp',
    },
    patch = {
      color = '#e84d31',
      cterm_color = '166',
      icon = vim.trim(icons.Git),
      name = 'Patch',
    },
    md = {
      color = '#6fb5ca',
      cterm_color = '74',
      icon = vim.trim(icons.Markdown),
      name = 'Md',
    },
    mdx = {
      color = '#6fb5ca',
      cterm_color = '74',
      icon = vim.trim(icons.Markdown),
      name = 'Mdx',
    },
    markdown = {
      color = '#6fb5ca',
      cterm_color = '74',
      icon = vim.trim(icons.Markdown),
      name = 'Markdown',
    },
    zip = {
      color = '#e84d31',
      cterm_color = '166',
      icon = vim.trim(icons.Zip),
      name = 'Zip',
    },
  },
  override_by_filename = {
    run_datasets = {
      color = '#65767a',
      cterm_color = '238',
      icon = vim.trim(icons.Sh),
      name = 'ShellRunDatasets',
    },
    ['package.json'] = {
      color = '#bbbbbb',
      cterm_color = '250',
      icon = vim.trim(icons.Lock),
      name = 'PackageJson',
    },
    ['package-lock.json'] = {
      color = '#bbbbbb',
      cterm_color = '250',
      icon = vim.trim(icons.Lock),
      name = 'PackageLockJson',
    },
    ['.luacheckrc'] = {
      color = '#6d8086',
      cterm_color = '66',
      icon = vim.trim(icons.Config),
      name = 'LuaCheckRc',
    },
    ['.gitattributes'] = {
      color = '#e84d31',
      cterm_color = '239',
      icon = vim.trim(icons.Git),
      name = 'GitAttributes',
    },
    ['.gitconfig'] = {
      color = '#e84d31',
      cterm_color = '239',
      icon = vim.trim(icons.Git),
      name = 'GitConfig',
    },
    ['.gitignore'] = {
      color = '#e84d31',
      cterm_color = '239',
      icon = vim.trim(icons.Git),
      name = 'GitIgnore',
    },
    ['.gitmodules'] = {
      color = '#e84d31',
      cterm_color = '239',
      icon = vim.trim(icons.Git),
      name = 'GitModules',
    },
  },
})
