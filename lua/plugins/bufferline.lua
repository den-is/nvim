-- https://github.com/akinsho/bufferline.nvim
-- :h bufferline-configuration
return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  opts = {
    options = {
      -- mode = "tabs",
      mode = "buffers",
      close_command = "bdelete! %d",
      show_tab_indicators = false,

      -- numbers = "both",
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          text_align = "center",
          separator = false,
        },
        {
          filetype = "undotree",
          text = "Undo Tree",
          text_align = "center",
          separator = false,
        },
      },
    },
  },
}
