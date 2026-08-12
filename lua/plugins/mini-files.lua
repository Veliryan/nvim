return {
  {
    "echasnovski/mini.files",
    version = false,

    keys = {
      {
        "<leader>ls",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = "Open Mini Files",
      },
    },

    opts = {
      -- Versteckte Dateien anzeigen
      options = {
        use_as_default_explorer = true,
        permanent_delete = false,
      },

      -- Fenster
      windows = {
        preview = true,
        width_focus = 30,
        width_nofocus = 15,
        width_preview = 60,
      },

      -- Navigation
      mappings = {
        close = "q",

        go_in = "<Right>",
        go_out = "<Left>",
        go_in_plus = "<CR>",

        reset = "<BS>",
        reveal_cwd = "@",

        synchronize = "w",
        trim_left = "<",
        trim_right = ">",
      },

      -- Vorschau
      content = {
        filter = nil,
        prefix = nil,
        sort = nil,
      },
    },
  },
}
