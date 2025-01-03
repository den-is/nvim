-- https://github.com/stevearc/oil.nvim
-- g? - help
-- :help oil-actions for a list of all available actions
return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  opts = {
    default_file_explorer = false, -- using nvim-tree
    view_options = {
      show_hidden = true,
    },
  },
}
