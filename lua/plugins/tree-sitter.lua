return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",

    opts = {
      ensure_installed = {
        "lua",
        "bash",
        "c",
        "cpp",
        "java",
        "kotlin",
        "python",
      },

      highlight = {
        enable = true,
      },

      indent = {
        enable = true,
      },
    },
  },
}
