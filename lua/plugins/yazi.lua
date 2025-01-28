-- https://github.com/mikavilpas/yazi.nvim
-- https://github.com/sxyazi/yazi
return {
  "mikavilpas/yazi.nvim",
  lazy = true, -- use `event = "VeryLazy"` for netrw replacement
  keys = {
    {
      "<leader>lf",
      "<cmd>Yazi<cr>",
      desc = "Open Yazi (file manager)",
    },
  },
  opts = {
    open_for_directories = true,
  },
}
