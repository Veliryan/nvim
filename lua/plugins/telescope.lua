return {
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim"
    },
    config = function()
      require("telescope").setup {
        extensions = {
          file_browser = {
            theme = "ivy",
            hijack_netrw = true,
            mappings = {
              ["i"] = {
              },
              ["n"] = {
              },
            },
          },
        },
      }
      require("telescope").load_extension "file_browser"

      vim.keymap.set('n', '<leader>ls', '<cmd>Telescope file_browser<cr>', { desc = 'Telescope file brower' })
      vim.keymap.set("n", "<leader>ll", function()
        require("telescope").extensions.file_browser.file_browser({
          path = vim.fn.expand("%:p:h"),
          select_buffer = true,
        })
      end, { desc = "File browser at current file" })

      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
    end
  },
}
