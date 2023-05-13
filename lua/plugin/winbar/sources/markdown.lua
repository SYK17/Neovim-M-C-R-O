local bar = require('plugin.winbar.bar')

local initialized = false
local heading_icons = { '󰉫 ', '󰉬 ', '󰉭 ', '󰉮 ', '󰉯 ', '󰉰 ' }
local groupid = vim.api.nvim_create_augroup('WinBarMarkdown', {})

---@class markdown_heading_symbol_t
---@field name string
---@field level number
---@field lnum number
local markdown_heading_symbol_t = {}
markdown_heading_symbol_t.__index = markdown_heading_symbol_t

---Create a new markdown heading symbol object
---@param opts markdown_heading_symbol_t?
---@return markdown_heading_symbol_t
function markdown_heading_symbol_t:new(opts)
  return setmetatable(
    vim.tbl_deep_extend('force', {
      name = '',
      level = 0,
      lnum = 0,
    }, opts or {}),
    self
  )
end

---@class markdown_heading_symbols_parsed_list_t
---@field end { lnum: number, inside_code_block: boolean }
---@field symbols markdown_heading_symbol_t[]
local markdown_heading_symbols_parsed_list_t = {}
markdown_heading_symbols_parsed_list_t.__index =
  markdown_heading_symbols_parsed_list_t

---Create a new markdown heading symbols parsed object
---@param opts markdown_heading_symbols_parsed_list_t?
function markdown_heading_symbols_parsed_list_t:new(opts)
  return setmetatable(
    vim.tbl_deep_extend('force', {
      ['end'] = { lnum = 0, inside_code_block = false },
      symbols = {},
    }, opts or {}),
    self
  )
end

---@type markdown_heading_symbols_parsed_list_t[]
local markdown_heading_buf_symbols = {}
setmetatable(markdown_heading_buf_symbols, {
  __index = function(_, k)
    markdown_heading_buf_symbols[k] =
      markdown_heading_symbols_parsed_list_t:new()
    return markdown_heading_buf_symbols[k]
  end,
})

---Parse markdown file and update markdown heading symbols
---Side effect: change markdown_heading_buf_symbols
---@param buf number buffer handler
---@param lnum_end number update symbols backward from this line (1-based, inclusive)
---@param incremental? boolean incremental parsing
---@return nil
local function parse_buf(buf, lnum_end, incremental)
  local symbols_parsed = markdown_heading_buf_symbols[buf]
  local lnum_start = symbols_parsed['end'].lnum + 1
  if not incremental then
    lnum_start = 0
    symbols_parsed.symbols = {}
    symbols_parsed['end'] = { lnum = 0, inside_code_block = false }
  end
  local lines = vim.api.nvim_buf_get_lines(buf, lnum_start, lnum_end, false)
  symbols_parsed['end'].lnum = lnum_start + #lines

  for idx, line in ipairs(lines) do
    if line:match('^```') then
      symbols_parsed['end'].inside_code_block =
        not symbols_parsed['end'].inside_code_block
    end
    if not symbols_parsed['end'].inside_code_block then
      local _, _, heading_notation, heading_str = line:find('^(#+)%s+(.*)')
      local level = heading_notation and #heading_notation or 0
      if level >= 1 and level <= 6 then
        table.insert(
          symbols_parsed.symbols,
          markdown_heading_symbol_t:new({
            name = heading_str,
            level = #heading_notation,
            lnum = idx + lnum_start,
          })
        )
      end
    end
  end
end

---Convert markdown heading symbols into a list of winbar symbols according to
---cursor position
---@param symbols markdown_heading_symbol_t[] markdown heading symbols
---@param cursor integer[] cursor position
---@return winbar_symbol_t[]
local function convert(symbols, cursor)
  local result = {}
  local current_level = 7
  for symbol in vim.iter(symbols):rev() do
    if symbol.lnum <= cursor[1] and symbol.level < current_level then
      current_level = symbol.level
      table.insert(
        result,
        1,
        bar.winbar_symbol_t:new({
          icon = heading_icons[symbol.level],
          name = symbol.name,
          icon_hl = 'markdownH' .. symbol.level,
        })
      )
      if current_level == 1 then
        break
      end
    end
  end
  return result
end

---Attach markdown heading parser to buffer
---@param buf number buffer handler
---@return nil
local function attach(buf)
  if vim.b[buf].winbar_markdown_heading_parser_attached then
    return
  end
  local function _update()
    local cursor = vim.api.nvim_win_get_cursor(0)
    markdown_heading_buf_symbols[buf] = markdown_heading_buf_symbols[buf]
      or markdown_heading_symbols_parsed_list_t:new()
    parse_buf(buf, cursor[1])
  end
  vim.b[buf].winbar_markdown_heading_parser_attached = vim.api.nvim_create_autocmd(
    { 'TextChanged', 'TextChangedI' },
    {
      desc = 'Update markdown heading symbols on buffer change.',
      group = groupid,
      buffer = buf,
      callback = _update,
    }
  )
  _update()
end

---Detach markdown heading parser from buffer
---@param buf number buffer handler
---@return nil
local function detach(buf)
  if vim.b[buf].winbar_markdown_heading_parser_attached then
    vim.api.nvim_del_autocmd(
      vim.b[buf].winbar_markdown_heading_parser_attached
    )
    vim.b[buf].winbar_markdown_heading_parser_attached = nil
    markdown_heading_buf_symbols[buf] = nil
  end
end

---Initialize markdown heading source
---@return nil
local function init()
  if initialized then
    return
  end
  initialized = true
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].filetype == 'markdown' then
      attach(buf)
    end
  end
  vim.api.nvim_create_autocmd({ 'FileType' }, {
    desc = 'Attach markdown heading parser to markdown buffers.',
    group = groupid,
    callback = function(info)
      if info.match == 'markdown' then
        attach(info.buf)
      else
        detach(info.buf)
      end
    end,
  })
  vim.api.nvim_create_autocmd({ 'BufDelete', 'BufUnload', 'BufWipeOut' }, {
    desc = 'Detach markdown heading parser from buffer on buffer delete/unload/wipeout.',
    group = groupid,
    callback = function(info)
      if vim.bo[info.buf].filetype == 'markdown' then
        detach(info.buf)
      end
    end,
  })
end

---Get winbar symbols from buffer according to cursor position
---@param buf number buffer handler
---@param cursor number[] cursor position
---@return winbar_symbol_t[] symbols winbar symbols
local function get_symbols(buf, cursor)
  if vim.bo[buf].filetype ~= 'markdown' then
    return {}
  end
  if not initialized then
    init()
  end
  local buf_symbols = markdown_heading_buf_symbols[buf]
  if buf_symbols['end'].lnum < cursor[1] then
    parse_buf(buf, cursor[1] + 200, true)
  end
  return convert(buf_symbols.symbols, cursor)
end

return {
  get_symbols = get_symbols,
}
