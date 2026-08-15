-- Almost all Plugin Specific Keybinds are found inside the plugins/<plugin>.lua

-- File Keybinds
-- save/quit --
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>', { desc = 'Write' })
vim.keymap.set('n', '<leader>q', '<cmd>quit<cr>', { desc = 'Close' })


-- Split Keybinds
-- creation --
vim.keymap.set('n', '<leader>sv', '<cmd>vsplit<cr><cmd>wincmd l<cr>', { desc = 'Vertical Split' })
vim.keymap.set('n', '<leader>sh', '<cmd>split<cr><cmd>wincmd j<cr>', { desc = 'Horizontal Split' })

-- movement --
vim.keymap.set('n', '<leader><LEFT>', '<cmd>wincmd h<cr>', { desc = 'Focus Left Split' })
vim.keymap.set('n', '<leader><RIGHT>', '<cmd>wincmd l<cr>', { desc = 'Focus Right Split' })
vim.keymap.set('n', '<leader><UP>', '<cmd>wincmd k<cr>', { desc = 'Focus Up Split' })
vim.keymap.set('n', '<leader><DOWN>', '<cmd>wincmd j<cr>', { desc = 'Focus Down Split' })


