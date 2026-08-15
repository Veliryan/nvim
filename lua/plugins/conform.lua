return {
  {
    "stevearc/conform.nvim",

    event = { "BufWritePre" },

    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        bash = { "shfmt" },
      },

      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    },

    keys = {
      {
        "<leader>=",
        function()
          require("conform").format({
            async = true,
            lsp_format = "fallback",
          })
        end,
        mode = { "n", "v" },
        desc = "Format buffer",
      },
    },
  },
}
