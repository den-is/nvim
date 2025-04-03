-- https://github.com/nvim-lualine/lualine.nvim
return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "AndreM222/copilot-lualine",
  },
  event = "VeryLazy",
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status")

    lualine.setup({
      options = {
        disabled_filetypes = { "alpha", "dashboard", "NvimTree", "undotree", "snacks_dashboard" },
      },
      sections = {
        lualine_c = {
          {
            "filename",
            -- or press Ctrl+g - show full path
            path = 1,
          },
        },
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          "copilot",
          "encoding",
          "fileformat",
          "filetype",
        },
      },
      ---- At the moment of writing 20240901:  Extensions are not working
      ---- https://github.com/nvim-lualine/lualine.nvim/issues/1262
      -- extensions = { "lazy", "mason" },
    })
  end,
}
