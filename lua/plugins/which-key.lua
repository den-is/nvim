-- https://github.com/folke/which-key.nvim
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {
    preset = "modern",
    keys = {
      -- not working if neoscroll.vim is enabled
      -- https://github.com/folke/which-key.nvim/issues/839
      scroll_down = "<c-d>",
      scroll_up = "<c-u>",
    },
  },
}
