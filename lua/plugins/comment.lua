return {
    {
        "numToStr/Comment.nvim",

        opts = {
            mappings = false,
        },

        keys = {
            -- Normal Mode: aktuelle Zeile
            {
                "<leader>h",
                "gcc",
                mode = "n",
                remap = true,
                desc = "Toggle comment",
            },

            -- Visual Mode: Auswahl
            {
                "<leader>h",
                "gc",
                mode = "v",
                remap = true,
                desc = "Toggle comment",
            },
        },
    },
}
