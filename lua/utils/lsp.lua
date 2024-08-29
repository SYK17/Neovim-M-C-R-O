local M = {}

---@type lsp_client_config_t
---@diagnostic disable-next-line: missing-fields
M.default_config = {
  root_patterns = require('utils.fs').root_patterns,
  init_options = { hostInfo = 'neovim' },
}

---@class vim.lsp.ClientConfig: lsp_client_config_t
---@class lsp_client_config_t
---@field cmd? (string[]|fun(dispatchers: table):table)
---@field cmd_cwd? string
---@field cmd_env? (table)
---@field detached? boolean
---@field workspace_folders? (table)
---@field capabilities? lsp.ClientCapabilities
---@field handlers? table<string,function>
---@field settings? table
---@field commands? table
---@field init_options? table
---@field name? string
---@field get_language_id? fun(bufnr: integer, filetype: string): string
---@field offset_encoding? string
---@field on_error? fun(code: integer)
---@field before_init? function
---@field on_init? function
---@field on_exit? fun(code: integer, signal: integer, client_id: integer)
---@field on_attach? fun(client: vim.lsp.Client, bufnr: integer)
---@field trace? 'off'|'messages'|'verbose'|nil
---@field flags? table
---@field root_dir? string
---@field root_patterns? string[]

---Wrapper of `vim.lsp.start()`, starts and attaches LSP client for
---the current buffer
---@param config lsp_client_config_t
---@param opts table?
---@return integer? client_id id of attached client or nil if failed
function M.start(config, opts)
  if vim.b.bigfile or vim.bo.bt == 'nofile' or vim.g.vscode then
    return
  end

  local cmd_type = type(config.cmd)
  local cmd_exec = cmd_type == 'table' and config.cmd[1]
  if cmd_type == 'table' and vim.fn.executable(cmd_exec or '') == 0 then
    return
  end

  local name = cmd_exec
  local bufname = vim.api.nvim_buf_get_name(0)

  ---Check if a directory is valid, return it if so, else return nil
  ---@param dir string?
  ---@return string?
  local function _validate(dir)
    -- For some special buffers like `fugitive:///xxx`, `vim.fs.root()`
    -- returns '.' as result, which is NOT a valid directory
    return dir
        and dir ~= '.'
        and (vim.uv.fs_stat(dir) or {}).type == 'directory'
        and dir
      or nil
  end

  local root_dir = _validate(
    vim.fs.root(
      bufname,
      vim.list_extend(
        config.root_patterns or {},
        M.default_config.root_patterns or {}
      )
    )
  ) or _validate(vim.fs.dirname(bufname))
  if not root_dir then
    return
  end

  return vim.lsp.start(
    vim.tbl_deep_extend('keep', config or {}, {
      name = name,
      root_dir = root_dir,
    }, M.default_config),
    opts
  )
end

---@class lsp_soft_stop_opts_t
---@field retry integer?
---@field interval integer?
---@field on_close fun(client: vim.lsp.Client)

---Soft stop LSP client with retries
---@param client_or_id integer|vim.lsp.Client
---@param opts lsp_soft_stop_opts_t?
function M.soft_stop(client_or_id, opts)
  local client = type(client_or_id) == 'number'
      and vim.lsp.get_client_by_id(client_or_id)
    or client_or_id --[[@as vim.lsp.Client]]
  if not client then
    return
  end
  opts = opts or {}
  opts.retry = opts.retry or 4
  opts.interval = opts.interval or 500
  opts.on_close = opts.on_close or function() end

  if client.is_stopped() then
    opts.on_close(client)
    return
  end

  if opts.retry < 0 then
    return
  end

  client.stop(opts.retry == 0)
  vim.defer_fn(function()
    opts.retry = opts.retry - 1
    M.soft_stop(client, opts)
  end, opts.interval)
end

---Restart and reattach LSP client
---@param client_or_id integer|vim.lsp.Client
function M.restart(client_or_id)
  local client = type(client_or_id) == 'number'
      and vim.lsp.get_client_by_id(client_or_id)
    or client_or_id --[[@as vim.lsp.Client]]
  if not client then
    return
  end

  -- `client.attached_buffers` will be empty after client is stopped,
  -- save it before stopping
  local attached_buffers = vim.deepcopy(client.attached_buffers, true)
  local config = client.config
  M.soft_stop(client, {
    on_close = function()
      for buf, _ in pairs(attached_buffers) do
        if not vim.api.nvim_buf_is_valid(buf) then
          return
        end
        vim.api.nvim_buf_call(buf, function()
          M.start(config)
        end)
      end
    end,
  })
end

return M
