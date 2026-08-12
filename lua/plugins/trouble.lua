return {
  {
    "folke/trouble.nvim",

    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },

    cmd = "Trouble",

    opts = {
      modes = {
        diagnostics = {
          auto_close = false,
          auto_preview = true,
        },

        symbols = {
          auto_preview = false,
        },
      },
    },

    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics",
      },

      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics",
      },

      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Document Symbols",
      },

      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP References",
      },

      {
        "<leader>xq",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix",
      },
    },
  },
}
