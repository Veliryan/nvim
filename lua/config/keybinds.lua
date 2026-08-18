-- Almost all Plugin Specific Keybinds are found inside the <plugin>.lua

-- @nav: Keybind - File
-- save/quit --
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>', { desc = 'Write' })
vim.keymap.set('n', '<leader>q', '<cmd>quit<cr>', { desc = 'Close' })
vim.keymap.set('n', '<leader>x', '<cmd>quitall!<cr>', { desc = 'Quitall' })


-- @nav: Keybind - Split
-- creation --
vim.keymap.set('n', '<leader>sv', '<cmd>rightbelow vsplit<cr>', { desc = 'Vertical Spllit' })
vim.keymap.set('n', '<leader>sh', '<cmd>rightbelow split<cr>', { desc = 'Horizontal Spllit' })
vim.keymap.set('n', '<leader>st', '<cmd>rightbelow vsplit | terminal<cr>', { desc = 'Terminal Spllit' })

-- movement --
vim.keymap.set('n', '<leader>h', '<cmd>wincmd h<cr>', { desc = 'Focus Left Spllit' })
vim.keymap.set('n', '<leader>j', '<cmd>wincmd j<cr>', { desc = 'Focus Down Spllit' })
vim.keymap.set('n', '<leader>k', '<cmd>wincmd k<cr>', { desc = 'Focus Up Spllit' })
vim.keymap.set('n', '<leader>l', '<cmd>wincmd l<cr>', { desc = 'Focus Right Spllit' })


-- @nav: Keybind - Clipboard
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>y', '"+y')


-- @nav: Keybind - Terminal
-- escape terminal --
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
