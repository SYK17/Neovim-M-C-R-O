local execute = vim.cmd

execute(':command TT NvimTreeToggle')
execute(':command TC NvimTreeClipboard')
execute(':command TQ NvimTreeClose')
execute(':command TFF NvimTreeFindFile')
execute(':command TFFT NvimTreeFindFileToggle')
execute(':command TF NvimTreeFocus')
execute(':command TO NvimTreeOpen')
execute(':command TR NvimTreeRefresh')
execute(':command TS NvimTreeResize')

-- Refresh tree after opening new file or write to files
execute [[ autocmd BufEnter,BufAdd,BufWritePost * lua require('nvim-tree.lib').refresh_tree() ]]

local g = vim.g
g.nvim_tree_highlight_opened_files = 2
g.nvim_tree_indent_markers = 1
g.nvim_tree_icons = {
  git = {
    unstaged = 'M ',
    staged = 'S ',
    unmerged = 'C ',
    renamed = 'R ﰲ',
    deleted = 'D 﫧',
    untracked = 'U ',
    ignored = 'i '
  },
  lsp = {
    error = '',
    warn = '',
    hint = '',
    info = ''
  }
}

local tree_cb = require 'nvim-tree.config'.nvim_tree_callback
require 'nvim-tree'.setup {
  view = {
    auto_resize = true,
    mappings = {
      list = {
        { key = {'<CR>', 'o',
          '<2-LeftMouse>'},             cb = tree_cb('edit') },
        { key = {'<2-RightMouse>',
          '<C-]>'},                     cb = tree_cb('cd') },
        { key = '<C-[>',                cb = tree_cb('dir_up') },
        { key = '<M-v>',                cb = tree_cb('vsplit') },
        { key = '<M-x>',                cb = tree_cb('split') },
        { key = '<M-t>',                cb = tree_cb('tabnew') },
        { key = '<',                    cb = tree_cb('prev_sibling') },
        { key = '>',                    cb = tree_cb('next_sibling') },
        { key = 'P',                    cb = tree_cb('parent_node') },
        { key = '<BS>',                 cb = tree_cb('close_node') },
        { key = '<Tab>',                cb = tree_cb('preview') },
        { key = '{',                    cb = tree_cb('first_sibling') },
        { key = '}',                    cb = tree_cb('last_sibling') },
        { key = 'I',                    cb = tree_cb('toggle_ignored') },
        { key = 'H',                    cb = tree_cb('toggle_dotfiles') },
        { key = '<C-r>',                cb = tree_cb('refresh') },
        { key = 'a',                    cb = tree_cb('create') },
        { key = 'X',                    cb = tree_cb('remove') },
        { key = 'T',                    cb = tree_cb('trash') },
        { key = 'r',                    cb = tree_cb('rename') },
        { key = 'R',                    cb = tree_cb('full_rename') },
        { key = 'x',                    cb = tree_cb('cut') },
        { key = 'yy',                   cb = tree_cb('copy') },
        { key = 'p',                    cb = tree_cb('paste') },
        { key = 'yn',                   cb = tree_cb('copy_name') },
        { key = 'yp',                   cb = tree_cb('copy_path') },
        { key = 'yap',                  cb = tree_cb('copy_absolute_path') },
        { key = '[c',                   cb = tree_cb('prev_git_item') },
        { key = ']c',                   cb = tree_cb('next_git_item') },
        { key = 's',                    cb = tree_cb('system_open') },
        { key = 'q',                    cb = tree_cb('close') },
        { key = 'g?',                   cb = tree_cb('toggle_help') },
      }
    }
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      error = '',
      warning = '',
      hint = '',
      info = ''
    }
  },
}
