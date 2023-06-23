local M = {}

---Cache git branch names for each path
---@type table<string, string>
local branch_cache = {}

---Print git command error
---@param cmd string[] shell command
---@param msg string error message
---@param lev number? log level to use for errors, defaults to WARN
---@return nil
function M.error(cmd, msg, lev)
  lev = lev or vim.log.levels.WARN
  vim.notify(
    '[git] failed to execute git command: '
      .. table.concat(cmd, ' ')
      .. '\n'
      .. msg,
    lev
  )
end

---Execute git command in given directory synchronously
---@param path string
---@param cmd string[] git command to execute
---@param error_lev number? log level to use for errors, hide errors if nil or false
---@reurn { success: boolean, output: string }
function M.dir_execute(path, cmd, error_lev)
  local shell_args = { 'git', '-C', path, unpack(cmd) }
  local shell_out = vim.fn.system(shell_args)
  if vim.v.shell_error ~= 0 then
    if error_lev then
      M.error(shell_args, shell_out, error_lev)
    end
    return {
      success = false,
      output = shell_out,
    }
  end
  return {
    success = true,
    output = shell_out,
  }
end

---Execute git command in current directory synchronously
---@param cmd string[] git command to execute
---@param error_lev number? log level to use for errors, hide errors if nil or false
---@reurn { success: boolean, output: string }
function M.execute(cmd, error_lev)
  local shell_args = { 'git', unpack(cmd) }
  local shell_out = vim.fn.system(shell_args)
  if vim.v.shell_error ~= 0 then
    if error_lev then
      M.error(shell_args, shell_out, error_lev)
    end
    return {
      success = false,
      output = shell_out,
    }
  end
  return {
    success = true,
    output = shell_out,
  }
end

---Get the current branch name asynchronously
---@param path string? defaults to the path to the current buffer
---@return string branch name
function M.branch(path)
  path = vim.fs.normalize(path or vim.api.nvim_buf_get_name(0))
  local dir = vim.fs.dirname(path)
  if not branch_cache[dir] and vim.uv.fs_stat(dir) then
    vim.system(
      { 'git', 'rev-parse', '--abbrev-ref', 'HEAD' },
      { cwd = dir, stderr = false },
      function(err, _)
        branch_cache[dir] = err.stdout:gsub('\n.*', '')
      end
    )
  end
  return branch_cache[dir] or ''
end

return M
