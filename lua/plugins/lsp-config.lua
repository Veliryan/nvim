return {
    {
        "mason-org/mason.nvim",

        opts = {},
    },

    {
        "mason-org/mason-lspconfig.nvim",

        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
        },

        opts = {
            ensure_installed = {
                "lua_ls",
                "bashls",
                "clangd",
                "pyright",
            },

            automatic_enable = true,
        },
    },

    {
        "neovim/nvim-lspconfig",

        config = function()
            vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, {
                desc = "LSP: Go to definition",
            })
        end,
    },

    {
        "hrsh7th/nvim-cmp",

        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
        },

        event = "InsertEnter",

        config = function()
            local cmp = require("cmp")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end,
                },

                sources = {
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "path" },
                },

                mapping = cmp.mapping.preset.insert({
                    ["<Up>"] = cmp.mapping.select_prev_item(),
                    ["<Down>"] = cmp.mapping.select_next_item(),

                    ["<CR>"] = cmp.mapping.confirm({
                        select = false,
                    }),

                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                }),
            })
        end,
    },
}
