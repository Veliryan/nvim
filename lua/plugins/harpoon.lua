return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local harpoon = require("harpoon")

    harpoon:setup()

    vim.keymap.set("n", "<leader>ha", function()
      harpoon:list():add()
    end, { desc = "Harpoon: Mark file" })

    vim.keymap.set("n", "<leader>he", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Harpoon: Open menu" })

    vim.keymap.set("n", "<leader>hw", function()
      harpoon:list():next()
    end, { desc = "Harpoon: Next file" })

    vim.keymap.set("n", "<leader>hb", function()
      harpoon:list():prev()
    end, { desc = "Harpoon: Previous file" })

    --[[
		vim.keymap.set("n", "<leader>1", function()
			harpoon:list():select(1)
		end, { desc = "Harpoon: File 1" })
		--]]
  end,
}
