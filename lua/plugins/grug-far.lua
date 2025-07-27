-- https://github.com/MagicDuck/grug-far.nvim
return {
  "MagicDuck/grug-far.nvim",
  event = "VeryLazy",
  cmd = "GrugFar",
  keys = {
    {
      "<leader>sr",
      mode = { "n", "v" },
      desc = "Search and Replace (GrugFar)",
      function()
        local grug = require("grug-far")
        local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
        grug.open({
          transient = true,
          prefills = {
            filesFilter = ext and ext ~= "" and "*." .. ext or nil,
          },
        })
      end,
    },
  },
  opts = {
    engine = "ripgrep",
  },
}
