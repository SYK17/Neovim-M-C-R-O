local M = {}

M['mason-lspconfig'] = require('mason-lspconfig')

M.settings = {
  ensure_installed = require('utils.shared').langs:list('lsp_server')
}

M['mason-lspconfig'].setup(M.settings)

return M
