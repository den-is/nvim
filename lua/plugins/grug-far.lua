-- https://github.com/MagicDuck/grug-far.nvim
return {
  "MagicDuck/grug-far.nvim",
  event = "VeryLazy",
  cmd = "GrugFar",
  keys = {
    {
      "<leader>sr",
      mode = { "n", "v" },
      desc = "Search and Replace in project (GrugFar)",
      function()
        require("grug-far").open({ transient = true })
      end,
    },
    {
      "<leader>sb",
      mode = { "n", "v" },
      desc = "Search and Replace in buffer (GrugFar)",
      function()
        require("grug-far").open({
          transient = true,
          prefills = { paths = vim.fn.expand("%") },
        })
      end,
    },
    {
      "<leader>sw",
      mode = { "n", "v" },
      desc = "Search and Replace word (GrugFar)",
      function()
        require("grug-far").open({
          transient = true,
          prefills = { search = vim.fn.expand("<cword>") },
        })
      end,
    },
    {
      "<leader>sg",
      mode = { "n", "v" },
      desc = "Search and Replace selection (GrugFar)",
      function()
        require("grug-far").with_visual_selection({
          transient = true,
          prefills = { paths = vim.fn.expand("%") },
        })
      end,
    },
  },
  opts = {
    engine = "ripgrep",
  },
}
