local ft_list = require('utils.static').langs:list('ft')

return {
  {
    'neovim/nvim-lspconfig',
    ft = ft_list,
    cmd = { 'LspInfo', 'LspStart' },
    config = function()
      require('configs.nvim-lspconfig')
    end,
  },

  {
    'p00f/clangd_extensions.nvim',
    ft = { 'c', 'cpp' },
    dependencies = 'nvim-lspconfig',
    config = function()
      require('configs.clangd_extensions')
    end,
  },

  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'mason.nvim', 'nvim-lspconfig', },
    ft = ft_list,
    cmd = { 'LspInstall', 'LspUninstall' },
    config = function()
      require('configs.mason-lspconfig')
    end,
  },

  {
    'jose-elias-alvarez/null-ls.nvim',
    ft = ft_list,
    cmd = {
      'NullLsLog',
      'NullLsInfo',
      'NullLsFormatOnSaveToggle',
    },
    dependencies = { 'plenary.nvim' },
    config = function()
      require('configs.null-ls')
    end,
  },

  {
    'jay-babu/mason-null-ls.nvim',
    ft = ft_list,
    cmd = {
      'NullLsInstall',
      'NullLsUninstall',
    },
    dependencies = { 'mason.nvim', 'null-ls.nvim' },
    config = function()
      require('configs.mason-null-ls')
    end,
  },

  {
    'folke/neodev.nvim',
    ft = 'lua',
    config = function()
      require('configs.neodev')
    end,
  },
}
