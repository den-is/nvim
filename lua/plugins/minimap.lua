-- https://github.com/Isrothy/neominimap.nvim
return {
  "Isrothy/neominimap.nvim",
  version = "v3.x.x",
  lazy = false,
  keys = {
    { "<leader>mm", "<cmd>Neominimap Toggle<cr>", desc = "Toggle global minimap" },
    { "<leader>mo", "<cmd>Neominimap Enable<cr>", desc = "Enable global minimap" },
    { "<leader>mc", "<cmd>Neominimap Disable<cr>", desc = "Disable global minimap" },
    { "<leader>mr", "<cmd>Neominimap Refresh<cr>", desc = "Refresh global minimap" },
  },
  init = function()
    -- The following options are recommended when layout == "float"
    -- check options.lua - we already have these setting there
    -- vim.opt.wrap = false
    -- vim.opt.sidescrolloff = 36 -- Set a large value

    vim.g.neominimap = {
      auto_enable = true,
      exclude_filetypes = {
        "help",
        "bigfile", -- For Snacks.nvim
      },
      exclude_buftypes = {
        "nofile",
        "nowrite",
        "quickfix",
        "terminal",
        "prompt",
      },
      float = {
        minimap_width = 15,
      },
      click = {
        enabled = true,
        auto_switch_focus = true,
      },
    }
  end,
}
