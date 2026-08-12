return {
  {
    "nvim-lualine/lualine.nvim",

    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },

    opts = {
      options = {
        theme = "kanagawa",
        globalstatus = true,
        component_separators = "",
        section_separators = {
          left = "",
          right = "",
        },
        disabled_filetypes = {
          "NvimTree",
          "neo-tree",
          "mini.files",
        },
      },

      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(str)
              return str:sub(1, 1)
            end,
          },
        },

        lualine_b = {
          "branch",
          "diff",
          "diagnostics",
        },

        lualine_c = {
          {
            "filename",
            path = 1,
          },
        },

        lualine_x = {
          "encoding",
          "fileformat",
          "filetype",
        },

        lualine_y = {
          "progress",
        },

        lualine_z = {
          "location",
        },
      },
    },
  },
}
