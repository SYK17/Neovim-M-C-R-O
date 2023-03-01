local M = {}

---Jump to last accessed window on closing the current one
function M.win_close_jmp()
  -- Exclude floating windows
  if '' ~= vim.api.nvim_win_get_config(0).relative then return end
  -- Record the window we jump from (previous) and to (current)
  if nil == vim.t.winid_rec then
    vim.t.winid_rec = {
      prev = vim.fn.win_getid(),
      current = vim.fn.win_getid(),
    }
  else
    vim.t.winid_rec = {
      prev = vim.t.winid_rec.current,
      current = vim.fn.win_getid(),
    }
  end
  -- Loop through all windows to check if the previous one has been closed
  for winnr = 1, vim.fn.winnr('$') do
    if vim.fn.win_getid(winnr) == vim.t.winid_rec.prev then
      return -- Return if previous window is not closed
    end
  end
  vim.cmd('wincmd p')
end

---Jump to the position last time the buffer was edited.
---Source: https://www.reddit.com/r/neovim/comments/ucgxmj/comment/i6coai3/?utm_source=share&utm_medium=web2x&context=3
function M.last_pos_jmp()
  local ft = vim.opt_local.filetype:get()
  -- don't apply to git messages
  if (ft:match('commit') or ft:match('rebase')) then
    return
  end
  -- get position of last saved edit
  local markpos = vim.api.nvim_buf_get_mark(0, '"')
  local line = markpos[1]
  local col = markpos[2]
  -- if in range, go there
  if (line > 1) and (line <= vim.api.nvim_buf_line_count(0)) then
    vim.api.nvim_win_set_cursor(0, { line, col })
  end
end

---Close all floating windows.
---Source: https://github.com/wookayin/dotfiles/commit/96d935515486f44ec361db3df8ab9ebb41ea7e40
---@param key string|nil Fallback key to feed if no floating window is found.
function M.close_all_floatings(key)
  local count = 0
  local current_win = vim.api.nvim_get_current_win()
  -- close current win only if it's a floating window
  if vim.api.nvim_win_get_config(current_win).relative ~= '' then
    vim.api.nvim_win_close(current_win, true)
    return
  end
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win)
    -- close floating windows that can be focused
    if config.relative ~= '' and config.focusable then
      vim.api.nvim_win_close(win, false) -- do not force
      count = count + 1
    end
  end
  if count == 0 and key then  -- Fallback
    vim.api.nvim_feedkeys(
      vim.api.nvim_replace_termcodes(key, true, true, true), 'n', false)
  end
end

---Compute project directory for given path.
---@param fpath string
---@return string|nil
function M.proj_dir(fpath)
  if not fpath or fpath == '' then
    return nil
  end

  local root_patterns = {
    '.git',
    '.svn',
    '.bzr',
    '.hg',
    '.project',
    '.pro',
    '.sln',
    '.vcxproj',
    '.editorconfig',
  }

  local dirpath = vim.fs.dirname(fpath)
  local root = vim.fs.find(root_patterns,
    { path = dirpath, upward = true })[1]
  if root and vim.loop.fs_stat(root) then
    return vim.fs.dirname(root)
  end

  if dirpath then
    local dirstat = vim.loop.fs_stat(dirpath)
    if dirstat and dirstat.type == 'directory' then
      return dirpath
    end
  end

  return nil
end

---Toggle between light and dark background,
---setting global variables accordingly.
function M.toggle_background()
  if vim.o.background == 'dark' then
    vim.opt.background = 'light'
    vim.g.BACKGROUND = 'light'
  else
    vim.opt.background = 'dark'
    vim.g.BACKGROUND = 'dark'
  end
end

return M
