return {
  {
    "mrjones2014/smart-splits.nvim",

    keys = {
      {
        "<A-Left>",
        function()
          require("smart-splits").move_cursor_left()
        end,
        desc = "Move left",
      },
      {
        "<A-Right>",
        function()
          require("smart-splits").move_cursor_right()
        end,
        desc = "Move right",
      },
      {
        "<A-Up>",
        function()
          require("smart-splits").move_cursor_up()
        end,
        desc = "Move up",
      },
      {
        "<A-Down>",
        function()
          require("smart-splits").move_cursor_down()
        end,
        desc = "Move down",
      },
    },

    opts = {},
  },
}
