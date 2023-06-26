local utils = require('utils')
local osv = require('osv')

vim.api.nvim_create_user_command('DapOSVLaunchServer', function(info)
  local opts = utils.funcs.command.parse_cmdline_args(info.fargs)
  opts.port = opts.port or 8086
  osv.launch(opts)
end, {
  nargs = '*',
  complete = utils.funcs.command.complete({}, {
    'host',
    'port',
    config_file = function(arglead)
      return vim.fn.getcompletion((arglead:gsub('^%-%-[%w_]*=', '')), 'file')
    end,
  }),
  desc = [[
    Launches an osv debug server.
    Usage: DapOSVLaunchServer [--host=<host>] [--port=<port>] [--config_file=<config_file>]
  ]],
})
