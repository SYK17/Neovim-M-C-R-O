local fzf = require('fzf-lua')
local actions = require('fzf-lua.actions')
local utils = require('utils')

local e = vim.fn.shellescape

local img_preview_command = vim.g.modern_ui
    and vim.fn.executable('ueberzug') == 1
    and { 'ueberzug' }
  or nil
local html_preview_command = vim.fn.executable('w3m') == 1
    and { 'w3m', '-dump' }
  or nil
local pdf_preview_command = vim.fn.executable('pdftotext') == 1
    and { 'pdftotext', '-l', '10', '-nopgbrk', '-nodiag', '-q', '<file>', '-' }
  or nil

local cfg_smallwin_nopreview = {
  previewer = false,
  winopts = {
    height = 0.6,
    width = 0.55,
    row = 0.4,
  },
  fzf_opts = {
    ['--no-preview'] = '',
    ['--preview-window'] = e('hidden'),
  },
}

---Switch provider while preserving the last query and cwd
---@return nil
local function switch_provider()
  local opts = {
    query = fzf.config.__resume_data.last_query,
    cwd = fzf.config.__resume_data.opts.cwd,
  }
  fzf.builtin({
    actions = {
      ['default'] = function(selected)
        fzf[selected[1]](opts)
      end,
    },
  })
end

fzf.setup({
  -- Use nbsp in tty to avoid showing box chars
  nbsp = not vim.g.modern_ui and '\xc2\xa0' or nil,
  winopts = {
    height = 0.75,
    width = 0.75,
    row = 0.4,
    col = 0.5,
    border = vim.g.modern_ui and utils.static.borders.solid
      or utils.static.borders.single_clc,
    preview = {
      default = 'builtin',
      vertical = 'down:55%',
      horizontal = 'right:50%',
      scrollbar = false,
      delay = 32,
      winopts = {
        number = false,
        relativenumber = false,
      },
    },
    on_create = function()
      vim.keymap.set(
        't',
        '<C-r>',
        [['<C-\><C-N>"' . nr2char(getchar()) . 'pi']],
        { expr = true, buffer = true }
      )
    end,
  },
  hls = {
    normal = 'TelescopePromptNormal',
    border = 'TelescopePromptBorder',
    title = 'TelescopeTitle',
    help_normal = 'TelescopeNormal',
    help_border = 'TelescopeBorder',
    preview_normal = 'TelescopeNormal',
    preview_border = 'TelescopeBorder',
    preview_title = 'TelescopeTitle',
    -- Builtin preview only
    cursor = 'Cursor',
    cursorline = 'TelescopePreviewLine',
    cursorlinenr = 'TelescopePreviewLine',
    search = 'IncSearch',
  },
  fzf_colors = {
    ['fg'] = { 'fg', 'TelescopeNormal' },
    ['bg'] = { 'bg', 'TelescopePromptNormal' },
    ['hl'] = { 'fg', 'TelescopeMatching' },
    ['fg+'] = { 'fg', 'TelescopeSelection' },
    ['bg+'] = { 'bg', 'TelescopeSelection' },
    ['hl+'] = { 'fg', 'TelescopeMatching' },
    ['info'] = { 'fg', 'TelescopePromptCounter' },
    ['border'] = { 'fg', 'TelescopeBorder' },
    ['gutter'] = { 'bg', 'TelescopePromptNormal' },
    ['prompt'] = { 'fg', 'TelescopePromptPrefix' },
    ['pointer'] = { 'fg', 'TelescopeSelectionCaret' },
    ['marker'] = { 'fg', 'TelescopeMultiIcon' },
  },
  keymap = {
    -- Overrides default completion completely
    builtin = {
      ['<F1>'] = 'toggle-help',
      ['<F2>'] = 'toggle-fullscreen',
      -- Only valid with the 'builtin' previewer
      ['<F3>'] = 'toggle-preview-wrap',
      ['<F4>'] = 'toggle-preview',
      -- Rotate preview clockwise/counter-clockwise
      ['<F5>'] = 'toggle-preview-ccw',
      ['<F6>'] = 'toggle-preview-cw',
      ['<S-down>'] = 'preview-page-down',
      ['<M-[>'] = 'preview-page-up',
      ['<M-]>'] = 'preview-page-reset',
    },
    fzf = {
      -- fzf '--bind=' options
      ['ctrl-z'] = 'abort',
      ['ctrl-k'] = 'kill-line',
      ['ctrl-u'] = 'unix-line-discard',
      ['ctrl-a'] = 'beginning-of-line',
      ['ctrl-e'] = 'end-of-line',
      ['alt-a'] = 'toggle-all',
      ['alt-}'] = 'last',
      ['alt-{'] = 'first',
      -- Only valid with fzf previewers (bat/cat/git/etc)
      ['f3'] = 'toggle-preview-wrap',
      ['f4'] = 'toggle-preview',
      ['alt-]'] = 'preview-page-down',
      ['alt-['] = 'preview-page-up',
    },
  },
  actions = {
    files = {
      ['default'] = function(selected, opts)
        if #selected > 1 then
          actions.file_sel_to_qf(selected, opts)
          vim.cmd.cfirst()
          vim.cmd.copen()
        else
          actions.file_edit(selected, opts)
        end
      end,
      ['alt-s'] = actions.file_split,
      ['alt-v'] = actions.file_vsplit,
      ['alt-t'] = actions.file_tabedit,
      ['alt-q'] = function(selected, opts)
        actions.file_sel_to_qf(selected, opts)
        if #selected > 1 then
          vim.cmd.cfirst()
          vim.cmd.copen()
        end
      end,
      ['alt-l'] = function(selected, opts)
        actions.file_sel_to_ll(selected, opts)
        if #selected > 1 then
          vim.cmd.cfirst()
          vim.cmd.copen()
        end
      end,
      ['ctrl-_'] = switch_provider,
    },
    buffers = {
      ['default'] = actions.buf_edit,
      ['alt-s'] = actions.buf_split,
      ['alt-v'] = actions.buf_vsplit,
      ['alt-t'] = actions.buf_tabedit,
      ['ctrl-_'] = switch_provider,
    },
  },
  fzf_opts = {
    ['--no-scrollbar'] = '',
    ['--no-separator'] = '',
    ['--info'] = e('inline-right'),
    ['--layout'] = e('reverse'),
    ['--marker'] = e('+'),
    ['--pointer'] = e('→'),
    ['--prompt'] = e('/ '),
    ['--border'] = e('none'),
    ['--padding'] = e('0,1'),
    ['--margin'] = e('0'),
    ['--preview-window'] = e('border-sharp'),
  },
  previewers = {
    builtin = {
      treesitter = {
        enable = true,
        disable = { 'tex', 'markdown' },
      },
      extensions = {
        ['html'] = html_preview_command,
        ['jpg'] = img_preview_command,
        ['png'] = img_preview_command,
        ['svg'] = img_preview_command,
        ['pdf'] = pdf_preview_command,
      },
    },
  },
  files = {
    fzf_opts = {
      ['--info'] = e('inline-right'),
    },
  },
  grep = {
    rg_opts = table.concat({
      '--hidden',
      '--follow',
      '--smart-case',
      '--column',
      '--line-number',
      '--no-heading',
      '--color=always',
      '-g=!.git/',
      '-e',
    }, ' '),
    fzf_opts = {
      ['--info'] = e('inline-right'),
    },
  },
  lsp = {
    finder = {
      fzf_opts = {
        ['--info'] = e('inline-right'),
      },
    },
    symbols = {
      symbol_icons = vim.tbl_map(vim.trim, utils.static.icons.kinds),
    },
  },
  builtin = cfg_smallwin_nopreview,
  command_history = cfg_smallwin_nopreview,
  commands = cfg_smallwin_nopreview,
  registers = cfg_smallwin_nopreview,
  search_history = cfg_smallwin_nopreview,
  menus = cfg_smallwin_nopreview,
  packadd = cfg_smallwin_nopreview,
  filetypes = cfg_smallwin_nopreview,
  spell_suggest = cfg_smallwin_nopreview,
  autocmds = {
    winopts = {
      preview = {
        layout = 'vertical',
      },
    },
  },
})

vim.keymap.set('n', '<Leader>.', fzf.files)
vim.keymap.set('n', "<Leader>'", fzf.resume)
vim.keymap.set('n', '<Leader>,', fzf.buffers)
vim.keymap.set('n', '<Leader>/', fzf.live_grep)
vim.keymap.set('n', '<Leader>?', fzf.live_grep)
vim.keymap.set('n', '<Leader>*', fzf.grep_cword)
vim.keymap.set('x', '<Leader>*', fzf.grep_visual)
vim.keymap.set('n', '<Leader>#', fzf.grep_cword)
vim.keymap.set('x', '<Leader>#', fzf.grep_visual)
vim.keymap.set('n', '<Leader>"', fzf.registers)
vim.keymap.set('n', '<Leader>F', fzf.builtin)
vim.keymap.set('n', '<Leader>o', fzf.oldfiles)
vim.keymap.set('n', '<Leader>s', fzf.lsp_document_symbols)
vim.keymap.set('n', '<Leader>S', fzf.lsp_live_workspace_symbols)
vim.keymap.set('n', '<Leader>q:', fzf.command_history)
vim.keymap.set('n', '<Leader>q/', fzf.command_history)
vim.keymap.set('n', '<Leader>f"', fzf.registers)
vim.keymap.set('n', '<Leader>f', fzf.builtin)
vim.keymap.set('n', '<Leader>f*', fzf.grep_cword)
vim.keymap.set('x', '<Leader>f*', fzf.grep_visual)
vim.keymap.set('n', '<Leader>f#', fzf.grep_cword)
vim.keymap.set('x', '<Leader>f#', fzf.grep_visual)
vim.keymap.set('n', '<Leader>f:', fzf.commands)
vim.keymap.set('n', '<Leader>f/', fzf.live_grep)
vim.keymap.set('n', '<Leader>f?', fzf.live_grep)
vim.keymap.set('n', '<Leader>fD', fzf.lsp_typedefs)
vim.keymap.set('n', '<Leader>fE', fzf.diagnostics_workspace)
vim.keymap.set('n', '<Leader>fH', fzf.highlights)
vim.keymap.set('n', "<Leader>f'", fzf.resume)
vim.keymap.set('n', '<Leader>fS', fzf.lsp_live_workspace_symbols)
vim.keymap.set('n', '<Leader>fa', fzf.autocmds)
vim.keymap.set('n', '<Leader>fb', fzf.buffers)
vim.keymap.set('n', '<Leader>fc', fzf.changes)
vim.keymap.set('n', '<Leader>fd', fzf.lsp_definitions)
vim.keymap.set('n', '<Leader>fe', fzf.diagnostics_document)
vim.keymap.set('n', '<Leader>ff', fzf.files)
vim.keymap.set('n', '<Leader>fg', fzf.git_status)
vim.keymap.set('n', '<Leader>fG', fzf.git_commits)
vim.keymap.set('n', '<Leader>fh', fzf.help_tags)
vim.keymap.set('n', '<Leader>fk', fzf.keymaps)
vim.keymap.set('n', '<Leader>fl', fzf.blines)
vim.keymap.set('n', '<Leader>fL', fzf.lines)
vim.keymap.set('n', '<Leader>fm', fzf.marks)
vim.keymap.set('n', '<Leader>fo', fzf.oldfiles)
vim.keymap.set('n', '<Leader>fq/', fzf.search_history)
vim.keymap.set('n', '<Leader>fq:', fzf.command_history)
vim.keymap.set('n', '<Leader>fq?', fzf.command_history)
vim.keymap.set('n', '<Leader>fr', fzf.lsp_references)
vim.keymap.set('n', '<Leader>fs', fzf.lsp_document_symbols)

-- Mimic fzf.vim's :FZF command
local fzf_cmd_body = {
  function(info)
    fzf.files({ cwd = info.fargs[1] })
  end,
  {
    nargs = '?',
    complete = 'dir',
    desc = 'Fuzzy find files.',
  },
}
vim.api.nvim_create_user_command('F', unpack(fzf_cmd_body))
vim.api.nvim_create_user_command('FZ', unpack(fzf_cmd_body))
vim.api.nvim_create_user_command('FZF', unpack(fzf_cmd_body))

---Set telescope default hlgroups for a borderless view
---@return nil
local function set_default_hlgroups()
  local hl_norm = utils.hl.get(0, { name = 'Normal', link = false })
  local hl_speical = utils.hl.get(0, { name = 'Special', link = false })
  local hl_tl_norm = utils.hl.get(0, {
    name = 'TelescopeNormal',
    link = false,
  })
  local hl_tl_pnorm = utils.hl.get(0, {
    name = 'TelescopePromptNormal',
    link = false,
  })
  if
    vim.tbl_isempty(hl_tl_norm)
    or vim.tbl_isempty(hl_tl_pnorm)
    or hl_tl_norm.bg == hl_norm.bg
    or hl_tl_pnorm.bg == hl_norm.bg
  then
    -- stylua: ignore start
    utils.hl.set(0, 'FzfLuaBufFlagAlt', { link = 'CursorLineNr' })
    utils.hl.set(0, 'FzfLuaBufFlagCur', { link = 'CursorLineNr' })
    utils.hl.set(0, 'FzfLuaBufLineNr', { link = 'LineNr' })
    utils.hl.set(0, 'FzfLuaBufName', { link = 'Directory' })
    utils.hl.set(0, 'FzfLuaBufNr', { link = 'LineNr' })
    utils.hl.set(0, 'FzfLuaCursor', { link = 'None' })
    utils.hl.set(0, 'FzfLuaHeaderBind', { link = 'Special' })
    utils.hl.set(0, 'FzfLuaHeaderText', { link = 'Special' })
    utils.hl.set(0, 'FzfLuaTabMarker', { link = 'Keyword' })
    utils.hl.set(0, 'FzfLuaTabTitle', { link = 'Title' })
    utils.hl.set(0, 'TelescopeBorder', { link = 'TelescopeNormal' })
    utils.hl.set(0, 'TelescopeNormal', { link = 'NormalFloat' })
    utils.hl.set(0, 'TelescopePromptBorder', { link = 'TelescopePromptNormal' })
    utils.hl.set(0, 'TelescopePromptNormal', utils.hl.blend('NormalFloat', 'Normal'))
    utils.hl.set(0, 'TelescopeSelection', { link = 'Visual' })
    utils.hl.set(0, 'TelescopeTitle', { fg = hl_norm.bg, bg = hl_speical.fg, bold = true })
    -- stylua: ignore end
  end
end

set_default_hlgroups()

vim.api.nvim_create_autocmd('ColorScheme', {
  group = vim.api.nvim_create_augroup('FzfLuaSetDefaultHlgroups', {}),
  desc = 'Set default hlgroups for fzf-lua.',
  callback = set_default_hlgroups,
})
