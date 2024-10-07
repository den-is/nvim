-- https://github.com/ThePrimeagen/harpoon/tree/harpoon2
return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "VeryLazy",
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    -- conflicts with treesitter-textobjects shortcut - "swap function args"
    vim.keymap.set("n", "<leader>a", function()
      harpoon:list():add()
    end, { desc = "Harpoon append" })

    vim.keymap.set("n", "<leader>0", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Harpoon UI" })

    vim.keymap.set("n", "<leader>1", function()
      harpoon:list():select(1)
    end, { desc = "Harpoon 1" })

    vim.keymap.set("n", "<leader>2", function()
      harpoon:list():select(2)
    end, { desc = "Harpoon 2" })

    vim.keymap.set("n", "<leader>3", function()
      harpoon:list():select(3)
    end, { desc = "Harpoon 3" })

    vim.keymap.set("n", "<leader>4", function()
      harpoon:list():select(4)
    end, { desc = "Harpoon 4" })

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<leader>p", function()
      harpoon:list():prev()
    end, { desc = "Harpoon previous" })

    vim.keymap.set("n", "<leader>n", function()
      harpoon:list():next()
    end, { desc = "Harpoon next" })
  end,
}
