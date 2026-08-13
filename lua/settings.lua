-- Basic Options
vim.cmd('colorscheme kanagawa-wave')

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- Keybinds
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>', { desc='Write' })
vim.keymap.set('n', '<leader>q', '<cmd>quit<cr>', { desc='Quit' })

vim.keymap.set('n', 'y', '"+y')
vim.keymap.set('v', 'y', '"+y')

vim.keymap.set('n', '<leader>ls', '<cmd>Ex<cr>', { desc='File Explorer' })
