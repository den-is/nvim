-- https://github.com/akinsho/bufferline.nvim
-- :h bufferline-configuration
return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  config = function()
    local bufferline = require("bufferline")
    bufferline.setup({
      options = {
        -- mode = "tabs",
        mode = "buffers",
        close_command = "bdelete! %d",
        show_tab_indicators = true,

        style_preset = bufferline.style_preset.no_italic,

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
          {
            filetype = "snacks_layout_box",
            text = "Explorer",
            text_align = "center",
            separator = false,
          },
          {
            filetype = "copilot-chat",
            text = "Copilot Chat",
            text_align = "center",
            separator = false,
          },
          {
            filetype = "codediff-explorer",
            text = "Diff Explorer",
            text_align = "center",
            separator = false,
          },
        },
      },
    })
  end,
}
