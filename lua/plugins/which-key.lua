return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {},
  config = function(_, opts)
    require("which-key").setup(opts)

    require("which-key").add({
      { "<leader>y",       hidden = true },
      { "<leader><LEFT>",  hidden = true },
      { "<leader><RIGHT>", hidden = true },
      { "<leader><UP>",    hidden = true },
      { "<leader><DOWN>",  hidden = true },
      { "<leader>x",       hidden = true },
      { "<leader>?",       hidden = true }
    })
  end,
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
