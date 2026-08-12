-- Basic Options
vim.cmd('colorscheme kanagawa-wave')


vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = true


-- Keybinds
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>', { desc='Write' })
vim.keymap.set('n', '<leader>q', '<cmd>quit<cr>', { desc='Quit' })

vim.keymap.set('n', 'y', '"+y')
vim.keymap.set('v', 'y', '"+y')

vim.keymap.set('n', 'sv', '<cmd>vsplit<cr>', { desc='Vertical Split' })
vim.keymap.set('n', 'sh', '<cmd>split<cr>', { desc='Horizontal Split' })
