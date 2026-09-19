return {
  -- https://github.com/mikavilpas/yazi.nvim
  -- https://github.com/sxyazi/yazi
  {
    -- Don't forget to set correct theme if needed. E.g. https://github.com/catppuccin/yazi
    "mikavilpas/yazi.nvim",
    lazy = true, -- use `event = "VeryLazy"` for netrw replacement
    keys = {
      { "<leader>ya", "<CMD>Yazi<CR>", desc = "Yazi - file manager" },
    },
    opts = {
      -- Set to true to open directories in Yazi instead of the default file explorer
      -- currently handled by nvim-tree
      open_for_directories = false,
    },
  },
  -- https://github.com/stevearc/oil.nvim
  -- g? - help
  -- :help oil-actions for a list of all available actions
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      default_file_explorer = false, -- using nvim-tree
      view_options = {
        show_hidden = true,
      },
    },
  },
}
