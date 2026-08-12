return {
  {
    "mrjones2014/smart-splits.nvim",

    keys = {
      -- Normal Mode
      {
        "<A-Left>",
        function()
          require("smart-splits").move_cursor_left()
        end,
        mode = { "n", "t" },
        desc = "Move left",
      },
      {
        "<A-Right>",
        function()
          require("smart-splits").move_cursor_right()
        end,
        mode = { "n", "t" },
        desc = "Move right",
      },
      {
        "<A-Up>",
        function()
          require("smart-splits").move_cursor_up()
        end,
        mode = { "n", "t" },
        desc = "Move up",
      },
      {
        "<A-Down>",
        function()
          require("smart-splits").move_cursor_down()
        end,
        mode = { "n", "t" },
        desc = "Move down",
      },
    },

    opts = {},
  },
}
