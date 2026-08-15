return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,

      ts_config = {
        lua = { "string" },
        javascript = { "template_string" },
        javascriptreact = { "template_string" },
        typescript = { "template_string" },
        typescriptreact = { "template_string" },
      },

      fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = [=[[%'%"%>%]%)%}%,]]=],
        end_key = "$",
        before_key = "h",
        after_key = "l",
        cursor_pos_before = true,
        keys = "qwertyuiopasdfghjklzxcvbnm",
        manual_position = true,
        highlight = "Search",
        highlight_grey = "Comment",
      },

      disable_filetype = {
        "TelescopePrompt",
        "spectre_panel",
      },
    },

    config = function(_, opts)
      local npairs = require("nvim-autopairs")

      npairs.setup(opts)

      local Rule = require("nvim-autopairs.rule")

      npairs.add_rules({
        Rule('"', '"', {
          "lua",
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "python",
          "rust",
          "go",
          "c",
          "cpp",
        }),
        Rule("'", "'", {
          "lua",
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "python",
          "rust",
          "go",
          "c",
          "cpp",
        }),
      })
    end,
  },
}
