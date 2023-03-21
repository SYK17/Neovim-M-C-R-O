vim.keymap.set({ 'n', 'x', 'x' }, '<Space>', '')
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Multi-window operations
vim.keymap.set('n', '<M-W>', '<C-w>W')
vim.keymap.set('n', '<M-H>', '<C-w>H')
vim.keymap.set('n', '<M-J>', '<C-w>J')
vim.keymap.set('n', '<M-K>', '<C-w>K')
vim.keymap.set('n', '<M-L>', '<C-w>L')
vim.keymap.set('n', '<M-=>', '<C-w>=')
vim.keymap.set('n', '<M-->', '<C-w>-')
vim.keymap.set('n', '<M-+>', '<C-w>+')
vim.keymap.set('n', '<M-_>', '<C-w>_')
vim.keymap.set('n', '<M-|>', '<C-w>|')
vim.keymap.set('n', '<M-<>', '<C-w><')
vim.keymap.set('n', '<M->>', '<C-w>>')
vim.keymap.set('n', '<M-p>', '<C-w>p')
vim.keymap.set('n', '<M-r>', '<C-w>r')
vim.keymap.set('n', '<M-v>', '<C-w>v')
vim.keymap.set('n', '<M-s>', '<C-w>s')
vim.keymap.set('n', '<M-x>', '<C-w>x')
vim.keymap.set('n', '<M-z>', '<C-w>z')
vim.keymap.set('n', '<M-c>', '<C-w>c')
vim.keymap.set('n', '<M-n>', '<C-w>n')
vim.keymap.set('n', '<M-o>', '<C-w>o')
vim.keymap.set('n', '<M-t>', '<C-w>t')
vim.keymap.set('n', '<M-T>', '<C-w>T')
vim.keymap.set('n', '<M-]>', '<C-w>]')
vim.keymap.set('n', '<M-^>', '<C-w>^')
vim.keymap.set('n', '<M-b>', '<C-w>b')
vim.keymap.set('n', '<M-d>', '<C-w>d')
vim.keymap.set('n', '<M-f>', '<C-w>f')
vim.keymap.set('n', '<M-}>', '<C-w>}')
vim.keymap.set('n', '<M-g>]', '<C-w>g]')
vim.keymap.set('n', '<M-g>}', '<C-w>g}')
vim.keymap.set('n', '<M-g>f', '<C-w>gf')
vim.keymap.set('n', '<M-g>F', '<C-w>gF')
vim.keymap.set('n', '<M-g>t', '<C-w>gt')
vim.keymap.set('n', '<M-g>T', '<C-w>gT')
vim.keymap.set('n', '<M-w>', '<C-w><C-w>')
vim.keymap.set('n', '<M-h>', '<C-w><C-h>')
vim.keymap.set('n', '<M-j>', '<C-w><C-j>')
vim.keymap.set('n', '<M-k>', '<C-w><C-k>')
vim.keymap.set('n', '<M-l>', '<C-w><C-l>')
vim.keymap.set('n', '<M-g><M-]>', '<C-w>g<C-]>')
vim.keymap.set('n', '<M-g><Tab>', '<C-w>g<Tab>')

-- Re-indent current buffer
vim.keymap.set('n', 'g=', 'gg=G``zz')

-- Buffer navigation
vim.keymap.set('n', '<Tab>', '<cmd>bn<CR>')
vim.keymap.set('n', '<S-Tab>', '<cmd>bp<CR>')
vim.keymap.set('n', '<M-C>', '<cmd>bd<CR>')
vim.keymap.set('n', '<C-n>', '<C-i>')

-- Correct misspelled word / mark as correct
vim.keymap.set('i', '<C-S-L>', '<Esc>[szg`]a')
vim.keymap.set('i', '<C-l>', '<C-G>u<Esc>[s1z=`]a<C-G>u')

-- Enter normal mode from arbitrary mode
vim.keymap.set({ 'n', 't', 'v', 'i', 'c' }, '<M-\\>', '<C-\\><C-n>')

vim.keymap.set('n', 'q', function()
  require('utils.funcs').close_all_floatings('q')
end)

vim.keymap.set('n', '<M-D>', function()
  require('utils.funcs').toggle_background()
end)
