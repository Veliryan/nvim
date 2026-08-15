-- Almost all Plugin Specific Keybinds are found inside the <plugin>.lua

-- File Keybinds
-- save/quit --
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>', { desc = 'Write' })
vim.keymap.set('n', '<leader>q', '<cmd>quit<cr>', { desc = 'Close' })
vim.keymap.set('n', '<leader>x', '<cmd>quitall!<cr>', { desc = 'Quitall' })


-- Split Keybinds
-- creation --
vim.keymap.set('n', '<leader>sv', '<cmd>rightbelow vsplit<cr>', { desc = 'Vertical Spllit' })
vim.keymap.set('n', '<leader>sh', '<cmd>rightbelow split<cr>', { desc = 'Horizontal Spllit' })
vim.keymap.set('n', '<leader>st', '<cmd>rightbelow vsplit | terminal<cr>i', { desc = 'Terminal Spllit' })

-- movement --
vim.keymap.set('n', '<leader><LEFT>', '<cmd>wincmd h<cr>', { desc = 'Focus Left Spllit' })
vim.keymap.set('n', '<leader><RIGHT>', '<cmd>wincmd l<cr>', { desc = 'Focus Right Spllit' })
vim.keymap.set('n', '<leader><UP>', '<cmd>wincmd k<cr>', { desc = 'Focus Up Spllit' })
vim.keymap.set('n', '<leader><DOWN>', '<cmd>wincmd j<cr>', { desc = 'Focus Down Spllit' })

-- slow resize --
vim.keymap.set('n', '<M-Left>', '<cmd>vertical resize +2<cr>', { desc = 'Decrease Split Width' })
vim.keymap.set('n', '<M-Right>', '<cmd>vertical resize -2<cr>', { desc = 'Increase Split Width' })
vim.keymap.set('n', '<M-Up>', '<cmd>resize -2<cr>', { desc = 'Increase Split Height' })
vim.keymap.set('n', '<M-Down>', '<cmd>resize +2<cr>', { desc = 'Decrease Split Height' })

-- fast resize --
vim.keymap.set('n', '<M-S-Left>', '<cmd>vertical resize +10<cr>', { desc = 'Decrease Split Width Fast' })
vim.keymap.set('n', '<M-S-Right>', '<cmd>vertical resize -10<cr>', { desc = 'Increase Split Width Fast' })
vim.keymap.set('n', '<M-S-Up>', '<cmd>resize -10<cr>', { desc = 'Increase Split Height Fast' })
vim.keymap.set('n', '<M-S-Down>', '<cmd>resize +10<cr>', { desc = 'Decrease Split Height Fast' })


-- Clipboard
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>y', '"+y')


-- Terminal
-- escape terminal --
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
