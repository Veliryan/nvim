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
                "python",

                "markdown",
                "markdown_inline",

                "html",
                "css",
                "javascript",
                "typescript",
                "tsx",
                "json",
                "jsonc",
            },

            highlight = {
                enable = true,
            },

            indent = {
                enable = true,
            },

            auto_install = true,
        },
    },
}
