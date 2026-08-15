return {
  {
    "neovim/nvim-lspconfig",

    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = {},
      },

      {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
          "mason-org/mason.nvim",
        },
      },

      {
        "hrsh7th/nvim-cmp",
        dependencies = {
          "hrsh7th/cmp-nvim-lsp",
          "hrsh7th/cmp-buffer",
          "hrsh7th/cmp-path",
          "L3MON4D3/LuaSnip",
          "saadparwaiz1/cmp_luasnip",
        },
      },
    },

    config = function()
      require("mason").setup()

      require("mason-lspconfig").setup({
        ensure_installed = {
          "bashls",
          "clangd",
          "lua_ls",
        },
      })

      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local cmp_lsp = require("cmp_nvim_lsp")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Up>"] = cmp.mapping.select_prev_item(),
          ["<C-Down>"] = cmp.mapping.select_next_item(),

          ["<Up>"] = cmp.mapping(function(fallback)
            fallback()
          end),

          ["<Down>"] = cmp.mapping(function(fallback)
            fallback()
          end),

          ["<C-Right>"] = cmp.mapping.confirm({
            select = true,
          }),

          ["<C-Space>"] = cmp.mapping.complete(),

          ["<C-e>"] = cmp.mapping.abort(),
        }),

        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),

        completion = {
          completeopt = "menu,menuone,noinsert",
        },
      })

      local capabilities = cmp_lsp.default_capabilities()

      local servers = {
        bashls = {
          capabilities = capabilities,
        },

        clangd = {
          capabilities = capabilities,

          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--completion-style=detailed",
            "--header-insertion=iwyu",
          },
        },

        lua_ls = {
          capabilities = capabilities,

          settings = {
            Lua = {
              diagnostics = {
                globals = {
                  "vim",
                },
              },

              workspace = {
                checkThirdParty = false,
              },

              telemetry = {
                enable = false,
              },

              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
      }

      for server, config in pairs(servers) do
        vim.lsp.config(server, config)
        vim.lsp.enable(server)
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          local opts = {
            buffer = event.buf,
            silent = true,
          }

          vim.keymap.set(
            "n",
            "<leader>ld",
            vim.lsp.buf.definition,
            vim.tbl_extend("force", opts, {
              desc = "LSP: Definition",
            })
          )

          vim.keymap.set(
            "n",
            "<leader>lD",
            vim.lsp.buf.declaration,
            vim.tbl_extend("force", opts, {
              desc = "LSP: Declaration",
            })
          )

          vim.keymap.set(
            "n",
            "<leader>lr",
            vim.lsp.buf.references,
            vim.tbl_extend("force", opts, {
              desc = "LSP: References",
            })
          )

          vim.keymap.set(
            "n",
            "K",
            vim.lsp.buf.hover,
            vim.tbl_extend("force", opts, {
              desc = "LSP: Hover",
            })
          )

          vim.keymap.set(
            "n",
            "<leader>ln",
            vim.lsp.buf.rename,
            vim.tbl_extend("force", opts, {
              desc = "LSP: Rename",
            })
          )

          vim.keymap.set(
            { "n", "v" },
            "<leader>la",
            vim.lsp.buf.code_action,
            vim.tbl_extend("force", opts, {
              desc = "LSP: Code Action",
            })
          )
        end,
      })

      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,

        update_in_insert = false,
        severity_sort = true,

        float = {
          border = "rounded",
          source = "if_many",
        },
      })
    end,
  },
}
