return {
    "numToStr/Comment.nvim",
    config = function()
        local comment = require("Comment")

        comment.setup()

        vim.keymap.set("n", "<leader>c", "gcc", {
            remap = true,
            desc = "Toggle comment",
        })

        vim.keymap.set("v", "<leader>c", "gc", {
            remap = true,
            desc = "Toggle comment",
        })
    end,
}
