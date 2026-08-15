return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',

  config = function()
    local ts = require('nvim-treesitter')

    ts.setup {
      install_dir = vim.fn.stdpath('data') .. '/site',
    }

    -- ensure installed
    ts.install {
      'bash',
      'c',
      'lua',
    }

    -- activate treesitter for supported filetypes
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local ft = vim.bo[args.buf].filetype
        local lang = vim.treesitter.language.get_lang(ft)

        if not lang then
          return
        end

        -- is parser already installed?
        if vim.treesitter.language.add(lang) then
          vim.treesitter.start(args.buf, lang)
          return
        end

        -- parser available but not installed?
        if vim.tbl_contains(ts.get_available(), lang) then
          ts.install({ lang }):await(function()
            if vim.api.nvim_buf_is_valid(args.buf)
                and vim.treesitter.language.add(lang)
            then
              vim.treesitter.start(args.buf, lang)
            end
          end)
        end
      end,
    })
  end,
}
