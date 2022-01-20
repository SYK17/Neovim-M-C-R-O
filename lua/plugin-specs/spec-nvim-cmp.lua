local get = require('utils/get')

return {
  get.spec('lspkind-nvim'),
  {
    'hrsh7th/nvim-cmp',
    event = { 'BufEnter', 'CmdLineEnter' },
    config = get.config('nvim-cmp'),
    requires = {
      get.spec('cmp-nvim-lsp'), get.spec('cmp-buffer'), get.spec('cmp-path'),
      get.spec('cmp-vsnip'), get.spec('vim-vsnip'), get.spec('cmp-calc'),
      get.spec('cmp-cmdline'), get.spec('cmp-emoji')
    },
    after = 'lspkind-nvim'
  }
}
