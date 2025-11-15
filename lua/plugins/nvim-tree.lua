-- https://github.com/nvim-tree/nvim-tree.lua
-- g? - to view shortcuts help. `:h nvim-tree-*` for extended help
return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    -- stylua: ignore start
    { "<leader>e", "<CMD>NvimTreeFindFileToggle<CR>", desc = "Open File Explorer - at current file location" },
    { "<leader>et", "<CMD>NvimTreeToggle<CR>", desc = "Toggle File Explorer" },
    { "<leader>ec", "<CMD>NvimTreeCollapse<CR>", desc = "Collapse File Explorer" },
    { "<leader>er", "<CMD>NvimTreeRefresh<CR>", desc = "Refresh File Explorer" },
    -- stylua: ignore end
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
      -- https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes#filter-directories-with-live-filter
      live_filter = {
        prefix = "[FILTER]: ",
        always_show_folders = false, -- Turn into false from true by default
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
          ".DS_Store",
          "__pycache__",
          "^.*.pyc$",
          "^.git$",
        },
      },
      git = {
        enable = true,
      },
    })
  end,
}
