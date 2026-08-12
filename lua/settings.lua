-- Basic Options
vim.cmd('colorscheme kanagawa-wave')


vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = true


-- Keybinds
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>', { desc='Write File' })
vim.keymap.set('n', '<leader>q', '<cmd>quit<cr>', { desc='Quit File' })
