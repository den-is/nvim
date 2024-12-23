-- https://github.com/nvim-tree/nvim-tree.lua
-- g? - to view shortcuts help. `:h nvim-tree-*` for extended help
return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  init = function()
    -- disable netrw at the very start of your init.lua
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
  config = function()
    local nvimtree = require("nvim-tree")

    nvimtree.setup({
      view = {
        width = 35,
        -- relativenumber = true,
      },
      renderer = {
        indent_markers = {
          enable = true,
        },
      },
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      filters = {
        dotfiles = false,
        git_ignored = false,
        -- vim regex patterns list for files/dirs to ignore
        -- https://vimregex.cm
        custom = {
          "\\.DS_Store",
          "__pycache__",
          "^.*\\.pyc$",
          "^\\.git$",
        },
      },
      git = {
        enable = true,
      },
    })

    vim.keymap.set("n", "<leader>e", "<CMD>NvimTreeToggle<CR>", { desc = "Open nvim-tree", noremap = true })
    vim.keymap.set(
      "n",
      "<leader>ef",
      "<CMD>NvimTreeFindFileToggle<CR>",
      { desc = "Open nvim-tree at location of current file" }
    )
    vim.keymap.set("n", "<leader>ec", "<CMD>NvimTreeCollapse<CR>", { desc = "Collapse nvim-tree" })
    vim.keymap.set("n", "<leader>er", "<CMD>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
  end,
}
