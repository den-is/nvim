-- https://github.com/Isrothy/neominimap.nvim
return {
  "Isrothy/neominimap.nvim",
  version = "v3.x.x",
  lazy = false,
  keys = {
    { "<leader>mm", "<CMD>Neominimap Toggle<CR>", desc = "Toggle global minimap" },
    { "<leader>mo", "<CMD>Neominimap Enable<CR>", desc = "Open global minimap" },
    { "<leader>mc", "<CMD>Neominimap Disable<CR>", desc = "Close global minimap" },
    { "<leader>mr", "<CMD>Neominimap Refresh<CR>", desc = "Refresh global minimap" },
  },
  init = function()
    -- The following options are recommended when layout == "float"
    -- check options.lua - we already have these setting there
    -- vim.opt.wrap = false
    -- vim.opt.sidescrolloff = 36 -- Set a large value

    vim.g.neominimap = {
      auto_enable = false,
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
