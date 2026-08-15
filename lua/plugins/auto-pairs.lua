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
        end_key = "$",
        before_key = "h",
        after_key = "l",
        manual_position = true,
      },

      disable_filetype = {
        "TelescopePrompt",
        "spectre_panel",
      },
    },
  },

  {
    "windwp/nvim-ts-autotag",
    ft = {
      "html",
      "xml",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
      "svelte",
    },
    opts = {},
  },
}
