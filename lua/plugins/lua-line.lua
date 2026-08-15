return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },

  config = function()
    -- time
    local function clock()
      return os.date('%H:%M:%S')
    end

    -- lsp
    local function lsp()
      local clients = vim.lsp.get_clients({ bufnr = 0 })

      if #clients == 0 then
        return 'LSP: -'
      end

      local names = {}

      for _, client in ipairs(clients) do
        table.insert(names, client.name)
      end

      return 'LSP: ' .. table.concat(names, ', ')
    end

    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'auto',

        component_separators = {
          left = '',
          right = '',
        },

        section_separators = {
          left = '',
          right = '',
        },

        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },

        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = false,

        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
          refresh_time = 16,

          events = {
            'WinEnter',
            'BufEnter',
            'BufWritePost',
            'SessionLoadPost',
            'FileChangedShellPost',
            'VimResized',
            'Filetype',
            'CursorMoved',
            'CursorMovedI',
            'ModeChanged',
          },
        },
      },

      sections = {
        lualine_a = {
          'mode',
        },

        lualine_b = {
          'branch',
          'diff',
          'diagnostics',
          'filename',
        },

        lualine_c = {
        },

        lualine_x = {
          lsp,
          'fileformat',
          'filetype',
        },

        lualine_y = {
        },

        lualine_z = {
          function()
            return os.date('%H:%M:%S')
          end,
        },
      },

      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          'filename',
        },
        lualine_x = {
          lsp,
          'location',
        },
        lualine_y = {},
        lualine_z = {},
      },

      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    }
  end,
}
